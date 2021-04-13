Module AutoGUI
  ; Screen utils.
  Procedure ScreenLocate(*pPos.Point, screen = 0)
    nbDesk = ExamineDesktops() - 1
    
    If screen > nbDesk Or screen < 0
      ProcedureReturn #False
    EndIf
    
    *pPos\x = DesktopX(screen)
    *pPos\y = DesktopY(screen)
    ProcedureReturn #True
  EndProcedure
  
  Procedure ScreenSize(*pSize.Point, screen = 0)
    nbDesk = ExamineDesktops() - 1
    
    If screen > nbDesk Or screen < 0
      ProcedureReturn #False
    EndIf
    
    *pSize\x = DesktopWidth(screen)
    *pSize\y = DesktopHeight(screen)
    ProcedureReturn #True
  EndProcedure
  
  Procedure ScreenCount()
    ProcedureReturn ExamineDesktops() - 1
  EndProcedure
  
  ; Mouse utils.
  Procedure MousePos(*pPos.Point)
    GetCursorPos_(*pPos)
  EndProcedure
  
  Procedure MouseJump(x, y)
    SetCursorPos_(x, y)
  EndProcedure
  
  Procedure MouseMove(x, y, interval = 50)
    p.Point
    GetCursorPos_(@p)
    
    offsetX = 0
    offsetY = 0
    
    While #True
      GetCursorPos_(@p)
      
      If p\x < x
        offsetX = 1
      Else
        offsetX = -1
      EndIf
      
      If p\y < y
        offsetY = 1
      Else
        offsetY = -1
      EndIf
      
      If p\x = x
        offsetX = 0
      EndIf
      
      If p\y = y
        offsetY = 0
      EndIf
      
      If offsetX = 0 And offsetY = 0
        Break
      EndIf
      
      SetCursorPos_(p\x + offsetX, p\y + offsetY)
      Delay(interval)
    Wend
  EndProcedure
  
  Procedure MouseClick(button = 0, interval = 1)
    If interval < 0
      interval = 0
    EndIf
    
    Select button
      Case AutoGUI::#MOUSE_LEFT
        mouse_event_(#MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
        Delay(interval)
        mouse_event_(#MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
      Case AutoGUI::#MOUSE_RIGHT
        mouse_event_(#MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0)
        Delay(interval)
        mouse_event_(#MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0)
      Case AutoGUI::#MOUSE_MIDDLE
        mouse_event_(#MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0)
        Delay(interval)
        mouse_event_(#MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0)
      Default
        ProcedureReturn #False
    EndSelect
    ProcedureReturn #True
  EndProcedure
  
  Procedure MouseDoubleClick()
    MouseClick(AutoGUI::#MOUSE_LEFT, 1)
    MouseClick(AutoGUI::#MOUSE_LEFT, 1)
  EndProcedure
  
  Procedure MouseIn(x, y)
    p.Point
    GetCursorPos_(@p)
    
    If p\x = x And p\y = y
      ProcedureReturn #True
    EndIf
    
    ProcedureReturn #False
  EndProcedure
  
  Procedure MouseDown(button = 0)
    Select button
      Case AutoGUI::#MOUSE_LEFT
        mouse_event_(#MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
      Case AutoGUI::#MOUSE_RIGHT
        mouse_event_(#MOUSEEVENTF_RIGHTDOWN, 0, 0, 0, 0)
      Case AutoGUI::#MOUSE_MIDDLE
        mouse_event_(#MOUSEEVENTF_MIDDLEDOWN, 0, 0, 0, 0)
      Default
        mouse_event_(#MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
    EndSelect
  EndProcedure
  
  Procedure MouseUp(button = 0)
    Select button
      Case AutoGUI::#MOUSE_LEFT
        mouse_event_(#MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
      Case AutoGUI::#MOUSE_RIGHT
        mouse_event_(#MOUSEEVENTF_RIGHTUP, 0, 0, 0, 0)
      Case AutoGUI::#MOUSE_MIDDLE
        mouse_event_(#MOUSEEVENTF_MIDDLEUP, 0, 0, 0, 0)
      Default
        mouse_event_(#MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
    EndSelect
  EndProcedure
  
  Procedure MouseScroll(scrolls = 1)
    mouse_event_(#MOUSEEVENTF_WHEEL, 0, 0, scrolls * 120, 0);
  EndProcedure
  
  Procedure MouseJumpDrag(x, y, interval = 0)
    dlay = interval / 2
    
    MouseDown(0)
    Delay(dlay)
    MouseJump(x, y)
    Delay(dlay)
    MouseUp(0)
  EndProcedure
  
  Procedure MouseMoveDrag(x, y, interval.f = 0.1)
    MouseDown(0)
    MouseMove(x, y, interval)
    MouseUp(0)
  EndProcedure
  
  ; Keyboard utils.
  Procedure KeyboardIsPressed(vKey)
    ProcedureReturn GetAsyncKeyState_(vKey) & $8000
  EndProcedure
  
  Procedure KeyboardPress(vKey, interval = 1)
    If interval < 0
      interval = 0
    EndIf
    
    keybd_event_(vKey, 0, 0, 0)
    Delay(interval)
    keybd_event_(vKey, 0, #KEYEVENTF_KEYUP, 0)
  EndProcedure
  
  Procedure KeyboardDown(vKey)
    keybd_event_(vKey, 0, 0, 0)
  EndProcedure
  
  Procedure KeyboardUp(vKey)
    keybd_event_(vKey, 0, #KEYEVENTF_KEYUP, 0)
  EndProcedure
  
  Procedure KeyboardHotKey(vKey1, vKey2, vKey3 = #PB_Ignore, interval = 1)
    keybd_event_(vKey1, 0, 0, 0)
    keybd_event_(vKey2, 0, 0, 0)
    If vKey3 <> #PB_Ignore
      keybd_event_(vKey3, 0, 0, 0)
    EndIf
    Delay(interval)
    keybd_event_(vKey1, 0, #KEYEVENTF_KEYUP, 0)
    keybd_event_(vKey2, 0, #KEYEVENTF_KEYUP, 0)
    If vKey3 <> #PB_Ignore
      keybd_event_(vKey3, 0, #KEYEVENTF_KEYUP, 0)
    EndIf
  EndProcedure
  
  Procedure IsUCase(sym.s)
    asym.a = Asc(sym)
    If asym < 65 Or asym > 90
      ProcedureReturn #False
    EndIf
    ProcedureReturn #True
  EndProcedure
  
  Procedure KeyboardWrite(text.s, interval = 100)
    For i = 1 To Len(text)
      sym.s = Mid(text, i, 1)
      ascSym = Asc(sym)
      
      If ascSym <> 32 And ascSym < 65 Or ascSym > 90 ; not space and not upper case
        If ascSym < 97 Or ascSym > 122               ; not lower case
          Continue
        EndIf
      EndIf
      
      If IsUCase(sym)
        KeyboardHotKey(#VK_SHIFT, Asc(UCase(sym)))
      Else
        KeyboardPress(Asc(UCase(sym)))
      EndIf

      Delay(interval)
    Next
  EndProcedure
  
  Procedure KeyboardWriteAny(text.s, interval = 100, wType = 0)
    If wType = AutoGUI::#KEYBOARD_WRITE_FAST
      SetClipboardText(text)
      Delay(interval)
      KeyboardHotKey(#VK_CONTROL, #VK_V)
      ProcedureReturn
    EndIf
    
    For i = 1 To Len(text)
      sym.s = Mid(text, i, 1)
      SetClipboardText("")
      SetClipboardText(sym)
      KeyboardHotKey(#VK_CONTROL, #VK_V)
      Delay(interval)
    Next i
  EndProcedure
  
  Procedure Capture(HDC, img, x, y, width, height)
    DDC = StartDrawing(ImageOutput(img))
    BitBlt_(DDC, 0, 0, width, height, HDC, x, y, #SRCCOPY)
    StopDrawing()
  EndProcedure
  
  Procedure CaptureWindow(wndName.s, img)
    wnd = AutoGUI::_findwnd(wndName)
    If Not wnd : ProcedureReturn #False : EndIf
    
    rc.Rect : GetWindowRect_(wnd, @rc)
    wdc = GetDC_(wnd)
    
    AutoGUI::Capture(wdc, img, 0, 0, rc\right - rc\left, rc\bottom - rc\top)
    ProcedureReturn #True
  EndProcedure
  
  Procedure CaptureWindowPlace(wndName.s, *pWndPlace.wndplace_t)
    wnd = AutoGUI::_findwnd(wndName)
    If Not wnd : ProcedureReturn #False : EndIf
    
    rc.Rect : GetWindowRect_(wnd, @rc)
    
    *pWndPlace\pos\x = rc\left + 8
    *pWndPlace\pos\y = rc\top + 1
    *pWndPlace\size\x = rc\right - rc\left - 16
    *pWndPlace\size\y = rc\bottom - rc\top - 9
    ProcedureReturn #True
  EndProcedure
EndModule
; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 276
; FirstLine = 241
; Folding = -----