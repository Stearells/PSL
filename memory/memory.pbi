; Memory Utils for PureBasic.
; Author: Stearells (C) 2020.
; Do not delete or modify this text.

DeclareModule Memory
  ;Write/Copy/Fill
  Macro _write(pAddress, value, size = #PB_Byte)
    CompilerSelect size
      CompilerCase #PB_Byte
        PokeB(pAddress, value)
      CompilerCase #PB_Word
        PokeW(pAddress, value)
      CompilerCase #PB_Long
        PokeL(pAddress, value)
      CompilerCase #PB_Quad
        PokeI(pAddress, value)
      CompilerDefault
        PokeB(pAddress, value)
    CompilerEndSelect
  EndMacro
  
  Macro _copy(pSource, pDestination, size)
    CopyMemory(pSource, pDestination, size)
  EndMacro
  
  Macro _fill(pAddress, value, size)
    FillMemory(pAddress, size, value)
  EndMacro
  
  ; Debug
  Macro _dump(pAddress, size)
    Debug "__ dump at 0x" + Hex(pAddress) + " (+" + Str(size) + ") __"
    
    For i = 0 To size - 1
      offset = pAddress + i
      tmpVal.b = PeekB(offset)
      Debug "[+" + Str(i) + "] 0x" + Hex(offset) + ": 0x" + Hex(tmpVal, #PB_Byte) + " (" + Str(tmpVal) + ")"
    Next i
  EndMacro
  
  ; Allocation/DeAllocation
  Macro _alloc(size) : AllocateMemory(size, #PB_Memory_NoClear) : EndMacro
  Macro _free(pMem)  : FreeMemory(pMem) : EndMacro
  
  ; Protection
  Declare.l Unprotect(*pAddress, size)
  Declare   Reprotect(*pAddress, size, Protection)
  
  ; Utils
  Declare   FastSave(*pAddress, size)
  Declare   FindPattern(*pAddress, memSize, *pPattern, ptSize, nbCount)
  Declare.s ToAsm(*pAddress, size)
  
  ; File I/O
  Declare   SaveToFile(fileName.s, *pAddress, size)
  Declare   LoadFromFile(fileName.s)
  
  ; Dynamic library
  Declare   FindFunction(szLibraryName.s, szFunctionName.s)
EndDeclareModule

IncludeFile "memory.pb"
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 61
; FirstLine = 13
; Folding = --