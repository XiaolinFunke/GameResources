#SingleInstance force		;force a single instance
#HotkeyInterval 0		;disable the warning dialog if a key is held down
#InstallKeybdHook		;Forces the unconditional installation of the keyboard hook
#UseHook On			;might increase responsiveness of hotkeys. Beware: By default, hotkeys that use the keyboard hook cannot be triggered by means of the Send command
#MaxThreads 20			;use 20 (the max) instead of 10 threads
SetBatchLines, -1		;makes the script run at max speed
SetKeyDelay , -1, -1		;faster response (might be better with -1, 0)
;Thread, Interrupt , -1, -1	;not sure what this does, could be bad for timers 

;;;;; Make the icon the TFT icon (Author: NiJo?) ;;;;;  
regread, war, HKEY_CURRENT_USER, Software\Blizzard Entertainment\Warcraft III, ProgramX
menu, tray, Icon, %War%, 1, 1 

;;;;; Hotkeys ;;;;;
#ifWinActive, Warcraft III ;*new to ver 1.0.41.00* only run when war3 is running

;;;;; Variables ;;;;;
InChatRoomOn := False
InResourceMenu := False

;;;;;; For subgroup order modifier key, use mouse button, which sends Left arrow for me (useful for destro micro w/ statues)
;;;;;; Also can use ALT or Windows key (if you miss alt)
*Left::
sendinput, {Ctrl Down}
keywait, Left
sendinput, {Ctrl Up}
return
*LAlt::
sendinput, {Ctrl Down}
keywait, LAlt
sendinput, {Ctrl Up}
return
;;;;;; Disable windows key, make send alt instead
*LWin::
sendinput, {Ctrl Down}
keywait, LWin
sendinput, {Ctrl Up}
return

;;;;;;; spacebar is alt for beaconing purposes and alt-tab
*Space::
sendinput, {Alt Down}
keywait, Space
sendinput, {Alt Up}
return

;;;;; Enable/disable all hotkeys ;;;;;
;; For some reason the *~ commands do not work with warcraft
*Enter::
Suspend, Permit
Send, {Blind}{Enter}
if (InChatRoomOn == True)
  return
Suspend
if (A_IsSuspended == 1)
{
  SoundPlay,*16
  Sleep 150
  SoundPlay,*16
}
else
  SoundPlay,*-1
return

;;;;; Disable hotkeys for fast resource trading - Outdated with F4 Method;;;;;
*F11::
Suspend, Permit
Send, {Blind}{F11}
if (InChatRoomOn == True)
  return
Suspend
if (A_IsSuspended == 1)
{
  SoundPlay,*16
  Sleep 150
  SoundPlay,*16
}
else
  SoundPlay,*-1
return

*Pause::
Suspend, Permit
if (InChatRoomOn == False)
{
  Suspend, On
  InChatRoomOn := True
  InResourceMenu := False
  SoundPlay,*16
  Sleep 150
  SoundPlay,*16
}
else
{
  Suspend, Off
  InChatRoomOn := False
  SoundPlay,*-1
}
return

*Home::
Suspend, Permit
if (InChatRoomOn == False)
{
  Suspend, On
  InChatRoomOn := True
  InResourceMenu := False
  SoundPlay,*16
  Sleep 150
  SoundPlay,*16
	
}
else
{
  Suspend, Off
  InChatRoomOn := False
  SoundPlay,*-1
}
return

;;;;; Use tgbyhn instead of KEYPAD for inventory ;;;;;
t::Send, {Numpad7}
g::Send, {Numpad4}
b::Send, {Numpad1}
y::Send, {Numpad8}
h::Send, {Numpad5}
n::Send, {Numpad2}

+t::Send, +{Numpad7}
+g::Send, +{Numpad4}
+b::Send, +{Numpad1}
+y::Send, +{Numpad8}
+h::Send, +{Numpad5}
+n::Send, +{Numpad2}

;;;;;;; Make shift function to SET hotkey groups
;Shift & 1::Send, ^1
;Shift & 2::Send, ^2
;Shift & 3::Send, ^3
;Shift & 4::Send, ^4
;Shift & 5::Send, ^5
;Shift & 6::Send, ^6
;Shift & 7::Send, ^7
;Shift & 8::Send, ^8
;Shift & 9::Send, ^9
;Shift & 0::Send, ^0


;;;;;;; Make shift function to SET hotkey groups
+1::^1
+2::^2
+3::^3
+4::^4
+5::^5
+6::^6
+7::^7
+8::^8
+9::^9
+0::^0

;;;;;;; Make ctrl function to ADD TO hotkey groups
;;Note that we need to use ::Send here, instead of the 'remap' syntax of a::b, since remap will preserve any modifier keys held (which isn't a problem when changing shift to ctrl, since WC3 interprets Shift + Ctrl as SETTING a hotkey
Ctrl & 1::Send, +1
Ctrl & 2::Send, +2
Ctrl & 3::Send, +3
Ctrl & 4::Send, +4
Ctrl & 5::Send, +5
Ctrl & 6::Send, +6
Ctrl & 7::Send, +7
Ctrl & 8::Send, +8
Ctrl & 9::Send, +9
Ctrl & 0::Send, +0

;;;;;;; ` is backspace to cycle through town halls
`::Send, {Backspace}

;;;;;;  Capslock functions like shift to add to hotkey groups
;Capslock & 1::Send, +1
;Capslock & 2::Send, +2
;Capslock & 3::Send, +3
;Capslock & 4::Send, +4
;Capslock & 5::Send, +5
;Capslock & 6::Send, +6
;Capslock & 7::Send, +7
;Capslock & 8::Send, +8
;Capslock & 9::Send, +9
;Capslock & 0::Send, +0

;;;;;; For Heroes (for Sean, remove for Bryan)
;F3::F1
;F4::F2
;F2::F3

;;;;;; For resource trading F4 instead of F11 and F4 also closes the menu (usually it would just open it and enter to close)
*F4::
if (InResourceMenu == False)
{
  InResourceMenu := True
  Send, {Blind}{F11}
}
else
{
  Send, {Blind}{Enter}
  InResourceMenu := False
}
return

;;;;;; For pausing and unpausing quickly
*F5::
Send {F10}m{F10}
return

;;;;;; make Z esc for canceling
z::
Send, {Esc}
Send z
return

;;;;;; to go to last alert
;;Capslock & Space::Send, {Space}
;;+Space::Send, {Space}
