﻿; -----------------------------
; AutoGUI Module.
; Author: Stearells (C) 2021.
; -----------------------------

DeclareModule AutoGUI
  ; Constants (do not change it).
  #MOUSE_LEFT   = 0
  #MOUSE_RIGHT  = 1
  #MOUSE_MIDDLE = 2
  
  #KEYBOARD_WRITE_FAST = 0
  #KEYBOARD_WRITE_REALISTIC = 1
  
  ; Internal macro.
  Macro _allocimg(width, height)
    CreateImage(#PB_Any, width, height)
  EndMacro
  
  ; temp macros -> image module
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
  Declare KeyboardDown(vKey)
  Declare KeyboardUp(vKey)
  Declare KeyboardHotKey(vKey1, vKey2, vKey3 = #PB_Ignore, interval = 1)
  Declare KeyboardWrite(text.s, interval = 100)
  Declare KeyboardWriteAny(text.s, interval = 100, wType = 0)
  
  ; Capture utils.
  Declare Capture(HDC, img, x, y, width, height)
  Declare CaptureWindow(wndName.s, img)
  Declare CaptureWindowPlace(wndName.s, *pWndPlace.wndplace_t)
EndDeclareModule

IncludeFile "autogui.pb"
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 79
; FirstLine = 35
; Folding = --
; Executable = C:\Users\Stearells\Desktop\1.dll.exe