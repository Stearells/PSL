DeclareModule Naked
  Macro _Procedure(name)
    CompilerIf Defined(__naked__#name#, #PB_Label)
      CompilerError "Symbol " + dq#name#dq + dq()dq + " already defined"
    CompilerEndIf
    
    ! jmp __naked__#name#_end
    __naked__#name#:
  EndMacro
  
  Macro _EndProcedure(name)
    CompilerIf Defined(__naked__#name#_end, #PB_Label)
      CompilerError "Symbol " + dq#name#dq + dq()dq + " already defined"
    CompilerEndIf
    
    CompilerIf Not Defined(__naked__#name#, #PB_Label)
      CompilerError "Can not find NakedProcedure for " + dq#name#dq + dq()dq
    CompilerEndIf
    
    __naked__#name#_end:
    ! __naked__#name#_end:
  EndMacro
EndDeclareModule
Module Naked
  Macro dq
    "
  EndMacro
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 5
; Folding = -
; Executable = 1.exe
; Compiler = PureBasic 5.70 LTS (Windows - x86)