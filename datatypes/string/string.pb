﻿Module Strings
  Procedure.s GenerateCodeName(seed)
    RandomSeed(seed)
    
    ln = 2
    ATypes = 0
    
    maskA.s = "aeiou"
    maskB.s = "bcdfghjklmnpqrstvwxyz"
    
    resl.s = ""
    
    For i = 0 To ln
      If ATypes
        resl + Mid(maskB, Random(Len(maskB) - 1), 2)
        ATypes = 0
      Else
        resl + Mid(maskA, Random(Len(maskA)), 1)
        ATypes = 1
      EndIf
      
      If Len(resl) < 2
        resl = UCase(resl)
      EndIf
    Next i
    
    RandomSeed(Date())
    ProcedureReturn resl
  EndProcedure
  Procedure RegExprMatch(szString.s, Expression.s)
    regexpr = CreateRegularExpression(#PB_Any, Expression)
    If Not regexpr : ProcedureReturn #False : EndIf
    
    result = MatchRegularExpression(regexpr, szString)
    FreeRegularExpression(regexpr)
    ProcedureReturn result
  EndProcedure
  
  Procedure RegExprPos(szString.s, Expression.s, nbMatches)
    regexpr = CreateRegularExpression(#PB_Any, Expression)
    If Not regexpr : ProcedureReturn #False : EndIf
    
    counter = 0
    resl = 0
    
    ExamineRegularExpression(regexpr, szString)
    While NextRegularExpressionMatch(regexpr)
      If counter = nbMatches
        resl = RegularExpressionMatchPosition(regexpr)
        Break
      EndIf
      counter + 1
    Wend
    
    FreeRegularExpression(regexpr)
    ProcedureReturn resl
  EndProcedure
  
  Procedure.s RegExprResult(szString.s, Expression.s, nbMatches)
    regexpr = CreateRegularExpression(#PB_Any, Expression)
    If Not regexpr : ProcedureReturn "" : EndIf
    
    counter = 0
    resl.s = ""
    
    ExamineRegularExpression(regexpr, szString)
    While NextRegularExpressionMatch(regexpr)
      If counter = nbMatches
        resl = RegularExpressionMatchString(regexpr)
        Break
      EndIf
      counter + 1
    Wend
    
    FreeRegularExpression(regexpr)
    ProcedureReturn resl
  EndProcedure
  
  Procedure IsDigit(szString.s)
    ProcedureReturn Strings::RegExprMatch(szString, "^[0-9]+$")
  EndProcedure
  
  Procedure.s ParseWords(szString.s, nbWord)
    ProcedureReturn Strings::RegExprResult(szString, "\S+", nbWord)
  EndProcedure
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 28
; Folding = --