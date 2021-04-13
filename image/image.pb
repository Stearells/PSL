Module Image
  Procedure ConvertToArray(img, Array arr(2))
    StartDrawing(ImageOutput(img))
    For x = 0 To ImageWidth(img) - 1
      For y = 0 To ImageHeight(img) - 1
        arr(x, y) = Point(x, y)
      Next y
    Next x
    StopDrawing()
  EndProcedure
  
  Procedure ConvertToImage(img, Array arr(2))
    StartDrawing(ImageOutput(img))
    For x = 0 To ImageWidth(img) - 1
      For y = 0 To ImageHeight(img) - 1
        Plot(x, y, arr(x, y))
      Next y
    Next x
    StopDrawing()
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
  
  Procedure FxGrayscale(img)
    StartDrawing(ImageOutput(img))
    For x = 0 To ImageWidth(img) - 1
      For y = 0 To ImageHeight(img) - 1
        px = Point(x, y)
        
        r = Red(px) * 30
        g = Green(px) * 59
        b = Blue(px) * 11
        
        px = Abs((r + g + b) / 100)
        
        Plot(x, y, RGB(px, px, px))
      Next y
    Next x
    StopDrawing()
  EndProcedure
  
  Procedure FxSepia(img, k)
    StartDrawing(ImageOutput(img))
    For x = 0 To ImageWidth(img) - 1
      For y = 0 To ImageHeight(img) - 1
        px = Point(x, y)
        
        r = Red(px) * 30
        g = Green(px) * 59
        b = Blue(px) * 11
        
        px = Abs((r + g + b) / 100)
        
        sepR = px + k * 2
        sepG = px + k
        
        If sepR > 255 : sepR = 255 : EndIf
        If sepG > 255 : sepG = 255 : EndIf
        
        Plot(x, y, RGB(sepR, sepG, px))
      Next y
    Next x
    StopDrawing()
  EndProcedure
  
  Procedure FxNegate(img)
    StartDrawing(ImageOutput(img))
    For x = 0 To ImageWidth(img) - 1
      For y = 0 To ImageHeight(img) - 1
        px = Point(x, y)
        
        r = Red(px)
        g = Green(px)
        b = Blue(px)
        
        Plot(x, y, RGB(255 - r, 255 - g, 255 - b))
      Next y
    Next x
    StopDrawing()
  EndProcedure
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 88
; FirstLine = 45
; Folding = --