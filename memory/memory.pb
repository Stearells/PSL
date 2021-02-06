IncludeFile "memory.pbi"

Module Memory
  Procedure.l Unprotect(*pAddress, size)
    dwOld.l
    VirtualProtect_(*pAddress, size, #PAGE_EXECUTE_READWRITE, @dwOld)
    ProcedureReturn dwOld
  EndProcedure
  
  Procedure Reprotect(*pAddress, size, Protection)
    dwOld.l
    VirtualProtect_(*pAddress, size, Protection, @dwOld)
  EndProcedure
  
  ; x86 opcodes
  Macro _X86_JMP  : $E9 : EndMacro
  Macro _X86_CALL : $E8 : EndMacro
  Macro _X86_RET  : $C2 : EndMacro
  Macro _X86_NOP  : $90 : EndMacro
  
  Procedure JmpHook(*pSource, *pDestination)
    Memory::Unprotect(*pSource, $05)
    dwCalc.l = *pDestination - (*pSource + $05)
    Memory::_write(*pSource, _X86_JMP, #PB_Byte)
    Memory::_write(*pSource + $01, dwCalc, #PB_Long)
  EndProcedure
  
  Procedure CallHook(*pSource, *pDestination)
    Memory::Unprotect(*pSource, $05)
    dwCalc.l = *pDestination - (*pSource + $05)
    Memory::_write(*pSource, _X86_CALL, #PB_Byte)
    Memory::_write(*pSource + $01, dwCalc, #PB_Long)
  EndProcedure
  
  Procedure RetHook(*pAddress, code.w)
    Memory::Unprotect(*pAddress, $01)
    Memory::_write(*pAddress, _X86_RET, #PB_Byte)
    Memory::_write(*pAddress + $01, code, #PB_Word)
  EndProcedure
  
  Procedure NopHook(*pAddress, nbNops)
    Memory::Unprotect(*pAddress, nbNops)
    Memory::_fill(*pAddress, _X86_NOP, nbNops)
  EndProcedure
  
  ; undefine x86 opcodes
  UndefineMacro _X86_JMP
  UndefineMacro _X86_CALL
  UndefineMacro _X86_RET
  UndefineMacro _X86_NOP
  
  Procedure FastSave(*pAddress, size)
    *p = Memory::_alloc(size)
    If *p 
      Memory::_copy(*pAddress, *p, size)
    EndIf
    ProcedureReturn *p
  EndProcedure
  
  Procedure FindPattern(*pAddress, memSize, *pPattern, ptSize, nbCount)
    nbFinded = 0
    For i = 0 To memSize - ptSize + 1
      *tmp = Memory::FastSave(*pAddress + i, ptSize)
      rsl = CompareMemory(*pPattern, *tmp, ptSize)
      Memory::_free(*tmp)
      
      If rsl
        nbFinded + 1
        If nbFinded = nbCount
          ProcedureReturn i
        EndIf
      EndIf
    Next i
    
    ProcedureReturn -1
  EndProcedure
  
  Procedure.s ToAsm(*pAddress, size)
    res.s = ""
    
    ExamineAssembly(*pAddress, *pAddress + size)
    While NextInstruction()
      res + InstructionString() + ~"\n"
    Wend
    ProcedureReturn res
  EndProcedure
  
  Procedure SaveToFile(fileName.s, *pAddress, size)
    file = OpenFile(#PB_Any, fileName, #PB_File_SharedWrite)
    
    If Not file
      ProcedureReturn #False
    EndIf
    
    WriteData(file, *pAddress, size)
    CloseFile(file)
    
    ProcedureReturn #True
  EndProcedure
  
  Procedure LoadFromFile(fileName.s)
    fsz = FileSize(fileName)
    
    If fsz < 1
      ProcedureReturn #False
    EndIf
    
    *pTmp = Memory::_alloc(fsz)
    If Not *pTmp
      ProcedureReturn #False
    EndIf
    
    file = OpenFile(#PB_Any, fileName, #PB_File_SharedRead)
    If Not file
      FreeMemory(*pTmp)
      ProcedureReturn #False
    EndIf
    
    ReadData(file, *pTmp, fsz)
    CloseFile(file)
    ProcedureReturn *pTmp
  EndProcedure
  
  Procedure SaveStructure(fileName.s, *pStruct, size)
    ProcedureReturn Memory::SaveToFile(fileName, *pStruct, size)
  EndProcedure
  
  Procedure LoadStructure(fileName.s, *pStruct)
    *tmp = Memory::LoadFromFile(fileName)
    
    If Not *tmp 
      ProcedureReturn #False
    EndIf
    
    CopyMemory(*tmp, *pStruct, MemorySize(*tmp))
    ProcedureReturn #True
  EndProcedure
  
  Procedure FindFunction(szLibraryName.s, szFunctionName.s)
    hLibrary = GetModuleHandle_(szLibraryName)
    *pBuf = UTF8(szFunctionName)
    *proc = GetProcAddress_(hLibrary, *pBuf)
    Memory::_free(*pBuf)
    ProcedureReturn *proc
  EndProcedure
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 124
; FirstLine = 97
; Folding = ----