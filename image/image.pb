IncludeFile "image.pbi"

Module ImageUtils
  Procedure GetTile(image, x, y, w, h)
    tmpImg = CreateImage(#PB_Any, w, h)
    If Not tmpImg : ProcedureReturn #False : EndIf
    
    Dim pixeldata.l(w, h)
    
    StartDrawing(ImageOutput(image))
    For xx = 0 To w - 1
      For yy = 0 To h - 1
        pixeldata(xx, yy) = Point(xx + x, yy + y)
      Next yy
    Next xx
    StopDrawing()
    
    StartDrawing(ImageOutput(tmpImg))
    For xx = 0 To w - 1
      For yy = 0 To h - 1
        Plot(xx, yy, pixeldata(xx, yy))
      Next yy
    Next xx
    StopDrawing()
    ProcedureReturn tmpImg
  EndProcedure
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 26
; Folding = -
; DisableDebugger