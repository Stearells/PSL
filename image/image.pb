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
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 32
; Folding = -