IncludeFile "..\memory\memory.pb"

DeclareModule GraphicsUtils
  Declare CopyToImage(out, x, y, w, h)
  Declare CopyToArray(out, x, y, w, h, Array dest.l(2))
  Declare CopyFromArray(out, x, y, Array src.l(2))
  Declare Show(out, w, h)
EndDeclareModule

DeclareModule GraphicsEffects
EndDeclareModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 10
; Folding = -