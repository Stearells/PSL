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
  
  ; Misc utils.
  Declare ConvertToArray(img, Array arr(2))
  Declare ConvertToImage(img, Array arr(2))
  Declare CalculatePixelsAverage(Array arr(1))
  Declare ConvertPartToArray(img, Array arr(2), x, y, width, height)
  
  ; Effects
  Declare FxGrayscale(img)
  Declare FxSepia(img, factor)
  Declare FxNegate(img)
  Declare FxNoise(img, factor)
  Declare FxBrightness(img, factor)
  Declare FxBinary(img, factor)
EndDeclareModule

IncludeFile "image.pb"
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 42
; Folding = --
; DisableDebugger