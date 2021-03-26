DeclareModule Simulations
  ; - constants -
  Enumeration
    #EMU_MOUSELEFT
    #EMU_MOUSERIGHT
    #EMU_MOUSEMIDDLE
  EndEnumeration
  
  ; - mouse macro -
  Macro _getMousePos(lpPoint)
    GetCursorPos_(lpPoint)
  EndMacro
  
  Macro _setMousePos(posX, posY)
    SetCursorPos_(posX, posY)
  EndMacro
  
  ; - keyboard macro -
  Macro _isKeyboardKeyPressed(vKey)
    GetAsyncKeyState_(vKey) & $8000
  EndMacro
  
  ; - mouse events -
  Declare MouseClick(button, waitTime)
  
  ; - keyboard events -
  Declare KeyboardPush(vKey, waitTime)
EndDeclareModule

IncludeFile "simulations.pb"
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 29
; Folding = -