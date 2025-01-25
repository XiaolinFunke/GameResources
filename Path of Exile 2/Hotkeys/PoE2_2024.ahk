#SingleInstance force		;force a single instance
#HotkeyInterval 0		;disable the warning dialog if a key is held down
#InstallKeybdHook		;Forces the unconditional installation of the keyboard hook
#UseHook On			;might increase responsiveness of hotkeys. Beware: By default, hotkeys that use the keyboard hook cannot be triggered by means of the Send command
#MaxThreads 20			;use 20 (the max) instead of 10 threads
SetBatchLines, -1		;makes the script run at max speed
SetKeyDelay , -1, -1		;faster response (might be better with -1, 0)

#if WinActive("ahk_exe PathOfExileSteam.exe") ;Only run when PoE window is active

;;;;; Other Variables ;;;;;
SuspendedKeys := False

;;;;; Enable/disable all hotkeys ;;;;;
*Pause::
Suspend, Permit
if (SuspendedKeys == False)
{
  Suspend, On
  SuspendedKeys := True
  SoundPlay,*16
  Sleep 150
  SoundPlay,*16
}
else
{
  Suspend, Off
  SuspendedKeys := False
  SoundPlay,*-1
}
return

*Home::
Suspend, Permit
if (SuspendedKeys == False)
{
  Suspend, On
  SuspendedKeys := True
  SoundPlay,*16
  Sleep 150
  SoundPlay,*16
	
}
else
{
  Suspend, Off
  SuspendedKeys := False
  SoundPlay,*-1
}
return


;;;;;; Make front side mouse button function as Ctrl
;;;;;; Note that my Logitech GHub binds it to Left, that's why Left is used here
;;;;;; A different key may be needed depending on your mouse settings
Left::Ctrl

;;Make capslock a usable key
CapsLock::
send m
return

;;Make scrollwheel up and down usable kes
WheelUp::
send l
return
WheelDown::
send k
return