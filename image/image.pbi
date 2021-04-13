; -----------------------------
; AutoGUI Module.
; Author: Stearells (C) 2021.
; -----------------------------

DeclareModule Image
  ; Internal macros.
  Macro _allocimg(width, height)
    CreateImage(#PB_Any, width, height)
  EndMacro
  
  Macro _freeimg(im)
    FreeImage(im)
  EndMacro
  
  Macro _saveimg(im, fname)
    SaveImage(im, fname)
  EndMacro
  
  Macro _loadimg(fname)
    LoadImage(#PB_Any, fname)
  EndMacro
  
  Macro _catchimg(addr, size)
    CatchImage(#PB_Any, addr, size)
  EndMacro
EndDeclareModule

IncludeFile "image.pb"
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 10
; Folding = --