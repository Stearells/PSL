Module Effect
  Procedure Grayscale(x, y, w, h)
    For xx = x To x + w - 1
      For yy = y To y + h - 1
        px = Point(xx, yy)
        
        r = Red(px) * 30
        g = Green(px) * 59
        b = Blue(px) * 11
        
        px = Abs((r + g + b) / 100)
        
        Plot(xx, yy, RGB(px, px, px))
      Next yy
    Next xx
  EndProcedure
  
  Procedure Sepia(x, y, w, h, factor)
    For xx = x To x + w - 1
      For yy = y To y + h - 1
        px = Point(xx, yy)
        
        r = Red(px) * 30
        g = Green(px) * 59
        b = Blue(px) * 11
        
        px = Abs((r + g + b) / 100)
        
        sepR = px + factor * 2
        sepG = px + factor
        
        If sepR > 255 : sepR = 255 : EndIf
        If sepG > 255 : sepG = 255 : EndIf
        
        Plot(xx, yy, RGB(sepR, sepG, px))
      Next yy
    Next xx
  EndProcedure
  
  Procedure Negate(x, y, w, h)
    For xx = x To x + w - 1
      For yy = y To y + h - 1
        px = Point(xx, yy)
        
        r = Red(px)
        g = Green(px)
        b = Blue(px)
        
        Plot(xx, yy, RGB(255 - r, 255 - g, 255 - b))
      Next yy
    Next xx
  EndProcedure
  
  Procedure Noise(x, y, w, h, factor)
    For xx = x To x + w - 1
      For yy = y To y + h - 1
        px = Point(xx, yy)
        
        rnd = Random(factor * 2) - factor
        
        r = Red(px) + rnd
        g = Green(px) + rnd
        b = Blue(px) + rnd
        
        If r < 0 : r = 0 : EndIf
        If r > 255 : r = 255 : EndIf
        
        If g < 0 : g = 0 : EndIf
        If g > 255 : g = 255 : EndIf
        
        If b < 0 : b = 0 : EndIf
        If b > 255 : b = 255 : EndIf
        
        Plot(xx, yy, RGB(r, g, b))
      Next yy
    Next xx
  EndProcedure
  
  Procedure Brightness(x, y, w, h, factor)
    For xx = x To x + w - 1
      For yy = y To y + h - 1
        px = Point(xx, yy)
        
        r = Red(px) + factor
        g = Green(px) + factor
        b = Blue(px) + factor
        
        If r < 0 : r = 0 : EndIf
        If r > 255 : r = 255 : EndIf
        
        If g < 0 : g = 0 : EndIf
        If g > 255 : g = 255 : EndIf
        
        If b < 0 : b = 0 : EndIf
        If b > 255 : b = 255 : EndIf
        
        Plot(xx, yy, RGB(r, g, b))
      Next yy
    Next xx
  EndProcedure
  
  Procedure Binary(x, y, w, h, factor)
    For xx = x To x + w - 1
      For yy = y To y + h - 1
        px = Point(xx, yy)
        
        r = Red(px)
        g = Green(px)
        b = Blue(px)
        
        px = r + g + b
        If px > (((255 + factor) / 2) * 3)
          Plot(xx, yy, $FFFFFF)
        Else
          Plot(xx, yy, 0)
        EndIf
      Next yy
    Next xx
  EndProcedure
  
  Procedure Pixelize(x, y, w, h, factor)
    im = GrabDrawingImage(#PB_Any, x, y, w, h)
    If Not IsImage(im)
      ProcedureReturn #False
    EndIf
    
    ResizeImage(im, w / factor, h / factor)
    ResizeImage(im, w, h)
    DrawImage(ImageID(im), x, y)
    FreeImage(im)
  EndProcedure
  
  Procedure Blur(x, y, w, h, factor)
    For i = 0 To factor
      Pixelize(x, y, w, h, factor - i + 1)
    Next i
  EndProcedure
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 134
; FirstLine = 83
; Folding = --