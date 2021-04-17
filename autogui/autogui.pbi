; -----------------------------
; AutoGUI Module.
; Author: Stearells (C) 2021.
; -----------------------------

IncludeFile "..\image\image.pbi"

DeclareModule AutoGUI
  ; Constants (do not change it).
  #MOUSE_LEFT   = 0
  #MOUSE_RIGHT  = 1
  #MOUSE_MIDDLE = 2
  
  #KEYBOARD_WRITE_FAST = 0
  #KEYBOARD_WRITE_REALISTIC = 1
  
  ; Internal macro.
  Macro _dc()
    GetDC_(0)
  EndMacro
  
  Macro _findwnd(wndname)
    FindWindow_(0, wndname)
  EndMacro
  
  ; Internal Structures
  Structure wndplace_t
    pos.Point
    size.Point
  EndStructure
  
  ; Screen utils.
  Declare ScreenLocate(*pPos.Point, screen = 0)
  Declare ScreenSize(*pSize.Point, screen = 0)
  Declare ScreenCount()
  
  ; Mouse utils.
  Declare MousePos(*pPos.Point)
  Declare MouseJump(x, y)
  Declare MouseMove(x, y, interval = 50)
  Declare MouseClick(button = 0, interval = 1)
  Declare MouseDoubleClick()
  Declare MouseDown(button = 0)
  Declare MouseUp(button = 0)
  Declare MouseIn(x, y)
  Declare MouseScroll(scrolls = 1)
  Declare MouseJumpDrag(x, y, interval = 0)
  Declare MouseMoveDrag(x, y, interval.f = 0.1)
  
  ; Keyboard utils.
  Declare KeyboardIsPressed(vKey)
  Declare KeyboardPress(vKey, interval = 1)
  Declare KeyboardPressSI(vKey, interval = 1)
  Declare KeyboardDown(vKey)
  Declare KeyboardDownSI(vKey)
  Declare KeyboardUp(vKey)
  Declare KeyboardUpSI(vKey)
  Declare KeyboardHotKey(vKey1, vKey2, vKey3 = #PB_Ignore, interval = 1)
  Declare KeyboardHotKeySI(vKey1, vKey2, vKey3 = #PB_Ignore, interval = 1)
  Declare KeyboardWriteSI(text.s, interval = 100)
  Declare KeyboardWriteAny(text.s, interval = 100, wType = 0)
  Declare KeyboardWriteAnySI(text.s, interval = 100, wType = 0)
  
  ; Capture utils.
  Declare Capture(HDC, img, x, y, width, height)
  Declare CaptureWindow(wndName.s, img)
  Declare CaptureWindowPlace(wndName.s, *pWndPlace.wndplace_t)
EndDeclareModule

IncludeFile "autogui.pb"

Delay(2000)
AutoGUI::KeyboardPressSI(#VK_W)

; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 72
; FirstLine = 25
; Folding = -
; EnableAdmin
; Executable = C:\Users\Stearells\Desktop\1.dll.exe
; DisableDebugger