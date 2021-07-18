DeclareModule Graphics
  Declare DrawRGBText(x, y, szStr.s)
EndDeclareModule

IncludeFile "graphics.pb"

UseJPEGImageEncoder()
im = CreateImage(#PB_Any, 800, 600)
StartDrawing(ImageOutput(im))
Graphics::DrawRGBText(0, 0, "$FFFFFFHello, World! This is $0000FF test $FFFFFF text! $FFFF00 Yeah! $0000FF")
StopDrawing()

SaveImage(im, "out.jpg")
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 9
; Folding = -