DeclareModule Graphics
  ; convertions
  Declare ConvertToArray(x, y, w, h, Array arr(2))
  Declare ConvertToImage(x, y, w, h, Array arr(2))
  Declare CalculatePixelsAverage(Array arr(1))
  Declare PixelDiff(px1, px2)
  
  ; drawing
  Declare DrawRGBText(x, y, szStr.s)
EndDeclareModule

IncludeFile "graphics.pb"

UseJPEGImageDecoder()
UseJPEGImageEncoder()
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 14
; Folding = -