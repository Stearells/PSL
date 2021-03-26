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
  
  Procedure FindFunction(szLibraryName.s, szFunctionName.s)
    hLibrary = GetModuleHandle_(szLibraryName)
    *pBuf = UTF8(szFunctionName)
    *proc = GetProcAddress_(hLibrary, *pBuf)
    Memory::_free(*pBuf)
    ProcedureReturn *proc
  EndProcedure
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 82
; FirstLine = 43
; Folding = --