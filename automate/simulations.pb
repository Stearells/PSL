IncludeFile "simulations.pbi"

Module Simulations
  Procedure MouseClick(button, waitTime)
    Select button
      Case Simulations::#EMU_MOUSELEFT
        e_down = #MOUSEEVENTF_LEFTDOWN
        e_up = #MOUSEEVENTF_LEFTUP
      Case Simulations::#EMU_MOUSERIGHT
        e_down = #MOUSEEVENTF_RIGHTDOWN
        e_up = #MOUSEEVENTF_RIGHTUP
      Case Simulations::#EMU_MOUSEMIDDLE
        e_down = #MOUSEEVENTF_MIDDLEDOWN
        e_up = #MOUSEEVENTF_MIDDLEUP
    EndSelect
    
    mouse_event_(e_down, 0, 0, 0, 0)
    Delay(waitTime)
    mouse_event_(e_up, 0, 0, 0, 0)
  EndProcedure
  
  Procedure KeyboardPush(vKey, waitTime)
    ip.Input
    
    ip\type = #INPUT_KEYBOARD
    ip\ki\time = 0
    ip\ki\dwExtraInfo = 0
    ip\ki\wVk = vKey
    
    SendInput_(1, @ip, SizeOf(Input))
    Delay(waitTime)
    
    ip\ki\dwFlags = #KEYEVENTF_KEYUP
    SendInput_(1, @ip, SizeOf(Input))
  EndProcedure
EndModule

; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 23
; FirstLine = 9
; Folding = -