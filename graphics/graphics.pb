Module GraphicsUtils
  Procedure CopyToImage(out, x, y, w, h)
    tmpImg = CreateImage(#PB_Any, w, h)
    If Not tmpImg : ProcedureReturn #False : EndIf
    
    Dim pixeldata.l(w, h)
    
    StartDrawing(out)
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
  
  Procedure CopyToArray(out, x, y, w, h, Array dest.l(2))
    StartDrawing(out)
    For xx = 0 To w - 1
      For yy = 0 To h - 1
        dest(xx, yy) = Point(xx + x, yy + y)
      Next yy
    Next xx
    StopDrawing()
  EndProcedure
  
  Procedure CopyFromArray(out, x, y, Array src.l(2))
    StartDrawing(out)
    For xx = 0 To ArraySize(src()) - 1
      For yy = 0 To ArraySize(src(), 2) - 1
        Plot(xx + x, yy + y, src(xx, yy))
      Next yy
    Next xx
    StopDrawing()
  EndProcedure
  
  Procedure.b GetPixBrightness(pix.l)
    ProcedureReturn (Red(pix) + Green(pix) + Blue(pix)) / 3
  EndProcedure
  
  Procedure Show(out, w, h)
    Dim pxd.l(w, h)
    GraphicsUtils::CopyToArray(out, 0, 0, w, h, pxd())
    
    wnd = OpenWindow(#PB_Any, 0, 0, w, h, "", #PB_Window_ScreenCentered | #PB_Window_SystemMenu)
    StartDrawing(WindowOutput(wnd))
    For x = 0 To w - 1
      For y = 0 To h - 1
        Plot(x, y, pxd(x, y))
      Next y
    Next x
    StopDrawing()
    
    While #True
      evID = WaitWindowEvent()
      
      If evID = #PB_Event_CloseWindow : Break : EndIf
      Delay(1)
    Wend
  EndProcedure
  
  Procedure ComparePixelMatrix(Array src.l(2), Array dst.l(2))
    srcPixelCount = (ArraySize(src(), 1) * ArraySize(src(), 2))
    dstPixelCount = (ArraySize(dst(), 1) * ArraySize(dst(), 2))
    
    w = 0
    h = 0
    t.f = 0
    
    If srcPixelCount =< dstPixelCount
      w = ArraySize(src(), 1)
      h = ArraySize(src(), 2)
      t = srcPixelCount
    Else
      w = ArraySize(dst(), 1)
      h = ArraySize(dst(), 2)
      t = dstPixelCount
    EndIf
    
    nbOk = 0
    
    For x = 0 To w - 1
      For y = 0 To h - 1
        If (src(x, y) / (dst(x, y) + 0.1)) < 1
          nbOk + 1
        EndIf
      Next y
    Next x
    
    r.f = (nbOk / t) * 100
    ProcedureReturn r
  EndProcedure
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; Folding = --
; Executable = C:\Users\stearells\Desktop\ex.exe