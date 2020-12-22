IncludeFile "effect.pbi"

Module GraphicsEffects
  Procedure Grayscale(out, x, y, w, h)
    StartDrawing(out)
    For xx = x To w - 1
      For yy = y To h - 1
        px = Point(xx, yy)
        px = ((Red(px) + Green(px) + Blue(px)) / 3) + l
        Plot(xx, yy, RGB(px, px, px))
      Next yy
    Next xx
    StopDrawing()
  EndProcedure
  
  Procedure.l calcAverage(px1.l, px2.l)
    r = (Red(px1) + Red(px2)) / 2
    g = (Green(px1) + Green(px2)) / 2
    b = (Blue(px1) + Blue(px2)) / 2
    ProcedureReturn RGB(r, g, b)
  EndProcedure
  
  Procedure Blur(out, x, y, w, h, nbPasses)
    StartDrawing(out)
    For i = 0 To nbPasses
      For xx = x To w - 2
        For yy = y To h - 2
          px1.l = calcAverage(Point(xx, yy), Point(xx + 1, yy))
          px2.l = calcAverage(Point(xx, yy + 1), Point(xx + 1, yy + 1))
          pxg.l = calcAverage(px1, px2)
          
          Box(xx, yy, 2, 2, pxg)
        Next yy
      Next xx
    Next i
    StopDrawing()
  EndProcedure
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 37
; Folding = -