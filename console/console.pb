IncludeFile "console.pbi"

Module Console
  Procedure PrintC(szString.s)
    For i = 1 To Len(szString)
      sym.s = Strings::_getc(szString, i)
      
      If sym = "{"
        If Strings::_getc(szString, i + 5) = "}"
          code.s = Mid(szString, i + 1, 4)
          
          If code = "dddd"
            ConsoleColor(7, 0)
            i + 5
            Continue
          EndIf
          
          If Strings::IsDigit(code)
            fg = Val(Mid(code, 1, 2))
            bg = Val(Mid(code, 3, 2))
            
            If fg < 16 And bg < 16
              ConsoleColor(fg, bg)
              i + 5
              Continue
            EndIf
          EndIf
        EndIf
      EndIf
      Print(sym)
    Next i
    ConsoleColor(7, 0)
  EndProcedure
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 33
; Folding = -