DeclareModule Strings
  Macro _getc(szString, idx)
    Mid(szString, idx, 1)
  EndMacro
  
  ; Regular Expressions
  Declare   RegExprMatch(szString.s, Expression.s)
  Declare   RegExprPos(szString.s, Expression.s, nbMatches)
  Declare.s RegExprResult(szString.s, Expression.s, nbMatches)
  
  ; String Parsing
  Declare   IsDigit(szString.s)
  Declare.s ParseWords(szString.s, nbWord)
EndDeclareModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 12
; Folding = -