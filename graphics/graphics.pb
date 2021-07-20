Module Graphics
  Procedure ConvertToArray(x, y, w, h, Array arr(2))
    For xx = x To w - 1
      For yy = y To h - 1
        arr(xx, yy) = Point(xx, yy)
      Next yy
    Next xx
  EndProcedure
  
  Procedure ConvertToImage(x, y, w, h, Array arr(2))
    For xx = x To w - 1
      For yy = y To h - 1
        Plot(xx, yy, arr(xx, yy))
      Next yy
    Next xx
  EndProcedure
  
  Procedure CalculatePixelsAverage(Array arr(1))
    avg = 0
    asz = ArraySize(arr())
    
    For i = 0 To asz
      r = Red(arr(i))
      g = Green(arr(i))
      b = Blue(arr(i))
      avg + ((r + g + b) / 3)
    Next i
    
    avg = avg / asz
    ProcedureReturn avg
  EndProcedure
  
  Procedure PixelDiff(px1, px2)
    r = Red(px1)
    g = Green(px1)
    b = Blue(px1)
    
    r2 = Red(px2)
    g2 = Green(px2)
    b2 = Blue(px2)
    
    ProcedureReturn (Abs(r - r2) + Abs(g - g2) + Abs(b - b2)) / 3
  EndProcedure
  
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
; CursorPosition = 41
; FirstLine = 31
; Folding = --