Module Graphics
  Procedure DrawRGBText(x, y, szStr.s)
    tmp.s = ""
    For i = 1 To Len(szStr)
      sym.s = Mid(szStr, i, 1)
      
      If sym = "$"
        ccode.s = Mid(szStr, i, 7)
        code = Val(ccode)
        
        FrontColor(code)
        DrawText(x + ofs, y, tmp)
        ofs + TextWidth(tmp)
        tmp = ""
        i + 6
        Continue
      EndIf
      tmp + sym
    Next i
  EndProcedure
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 2
; Folding = -