#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;;;Based off the dota 2 keys, some comments may be from that


#SingleInstance force		;force a single instance
#HotkeyInterval 0		;disable the warning dialog if a key is held down
#InstallKeybdHook		;Forces the unconditional installation of the keyboard hook
#UseHook On			;might increase responsiveness of hotkeys
#MaxThreads 20			;use 20 (the max) instead of 10 threads
SetBatchLines, -1		;makes the script run at max speed
SetKeyDelay , -1, -1		;faster response (might be better with -1, 0)
;Thread, Interrupt , -1, -1	;not sure what this does, could be bad for timers 

;;;;; Hotkeys ;;;;;
;Only active when dota 2 window is active
#ifWinActive, League of Legends

;;;;; Variables ;;;;;
;If False, hotkeys will be disabled
global HotkeysEnabled := True

;;;;;;Function to toggle whether the hotkeys are disabled or not
ToggleHotkeysEnabled()
{
  if (HotkeysEnabled == True)
  {
    Suspend, On
    HotkeysEnabled := False
    SoundPlay,*16
    Sleep 150
    SoundPlay,*16
  }
  else
  {
    Suspend, Off
    HotkeysEnabled := True
    SoundPlay,*-1
  }
  return
}

;;;;; Enable/disable all hotkeys ;;;;;
*Pause::
  Suspend, Permit ;Mark this subroutine as exempt from suspension
  ToggleHotkeysEnabled()
  return
*Home::
  Suspend, Permit ;Mark this subroutine as exempt from suspension
  ToggleHotkeysEnabled()
  return

;;;;;; Toggle hotkeys when Enter is pressed, for typing
*Enter::
Suspend, Permit ;Mark this subroutine as exempt from suspension
Send, {Blind}{Enter}
if (HotkeysEnabled == False)
  return ;If hotkeys aren't enabled, Enter should function normally
Suspend ;Toggle whether this script is suspended
if (A_IsSuspended == 1)
{
  SoundPlay,*16
  Sleep 150
  SoundPlay,*16
}
else
  SoundPlay,*-1
return




;;;;;; Make Caps lock a usable key (without toggling your upper/lower case)
*Capslock::m

;;;;;; Alias windows key to Alt
;Use remap syntax instead of Send so that it will trigger hotkeys that normally trigger with Alt
LWin::LAlt

;;;;;; Make front side mouse button function as Ctrl
;;;;;; Note that my Logitech GHub binds it to Right, that's why Right is used here
;;;;;; A different key may be needed depending on your mouse settings
Right::Ctrl