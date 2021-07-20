DeclareModule Effect
  Declare Grayscale(x, y, w, h)
  Declare Sepia(x, y, w, h, factor)
  Declare Negate(x, y, w, h)
  Declare Noise(x, y, w, h, factor)
  Declare Brightness(x, y, w, h, factor)
  Declare Binary(x, y, w, h, factor)
  Declare Pixelize(x, y, w, h, factor)
  Declare Blur(x, y, w, h, factor)
EndDeclareModule

IncludeFile "effect.pb"
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 11
; Folding = -