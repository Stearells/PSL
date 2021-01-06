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
  
  Procedure Push(stackID, value)
    If Not IsValid(stackID)
      ProcedureReturn -1
    EndIf
    
    msz = MemorySize(stacks(stackID)\sp)
    ReAllocateMemory(stacks(stackID)\sp, msz + stacks(stackID)\align)
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
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 80
; FirstLine = 46
; Folding = --