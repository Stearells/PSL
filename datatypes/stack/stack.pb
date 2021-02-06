IncludeFile "stack.pbi"

Module Stack
  Structure sstack
    *sp
    align.l
  EndStructure
  
  Global Dim stacks.sstack(0) ; global stacks partition
  
  ; -- macro's --
  
  ; macro for global stacks partition
  Macro _stacksSize()
    ArraySize(stacks())
  EndMacro
  
  ; macro for local stack
  Macro _unsafeSize(stackID)
    MemorySize(stacks(stackID)\sp) / stacks(stackID)\align
  EndMacro
  
  Macro _unsafeAlign(stackID)
    stacks(stackID)\align
  EndMacro
  
  ; -- end macro's --
  
  Procedure Create(align.l)
    If align < 1 : ProcedureReturn -1 : EndIf
    
    ssz = _stacksSize()
    
    If stacks(ssz)\sp
      ReDim stacks(ssz + 1)
      ssz + 1
    EndIf
    
    stacks(ssz)\sp = AllocateMemory(align)
    stacks(ssz)\align = align
    
    ProcedureReturn ssz
  EndProcedure
  
  Procedure IsValid(stackID)
    ssz = _stacksSize()
    
    If stackID < 0 Or stackID > ssz
      ProcedureReturn #False
    EndIf
    
    If Not stacks(stackID)\sp
      ProcedureReturn #False
    EndIf
    
    ProcedureReturn #True
  EndProcedure
  
  Procedure GetAlign(stackID)
    If Not IsValid(stackID)
      ProcedureReturn -1
    EndIf
    
    ProcedureReturn _unsafeAlign(stackID)
  EndProcedure
  
  Procedure GetSize(stackID)
    If Not IsValid(stackID)
      ProcedureReturn -1
    EndIf
    
    ProcedureReturn _unsafeSize(stackID)
  EndProcedure
  
  Procedure unsafe_LShift(stackID)
    *pTmp = stacks(stackID)\sp
    align = stacks(stackID)\align
    
    For i = 0 To MemorySize(*pTmp)
      CopyMemory(i + *pTmp + align, i + *pTmp, align)
      i + align
      Continue
    Next i
  EndProcedure
  
  Procedure dump(stackID)
    *sp = stacks(stackID)\sp
    align = stacks(stackID)\align
    
    For i = 0 To MemorySize(*sp)
      *p = AllocateMemory(align)
      CopyMemory(*sp + i, *p, align)
      
      s.s = ""
      For k = 0 To MemorySize(*p) - 1
        s + "0x" + Hex(PeekB(*p + k), #PB_Byte) + " "
      Next k
      
      FreeMemory(*p)
      Debug s
      i + align
      Continue
    Next i
  EndProcedure
  
  Procedure Push(stackID, value)
    If Not IsValid(stackID)
      ProcedureReturn -1
    EndIf
    
    For i = 0 To MemorySize(stacks(stackID)\sp)
      PokeB(i + stacks(stackID)\sp, Random(255))
    Next i
    
    dump(stackID)
    
    unsafe_LShift(stackID)
    
    dump(stackID)
  EndProcedure
EndModule

stack0 = Stack::Create(4)
stack1 = Stack::Create(2)

Debug "s0 ID = " + Str(stack0)
Debug "s1 ID = " + Str(stack1)

Debug "s0 Align = " + Str(Stack::GetAlign(stack0))
Debug "s1 Align = " + Str(Stack::GetAlign(stack1))

Debug "s0 Size = " + Str(Stack::GetSize(stack0))
Debug "s1 Size = " + Str(Stack::GetSize(stack1))

Debug "s0 Push = " + Str(Stack::Push(stack0, 4))
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 117
; FirstLine = 79
; Folding = --