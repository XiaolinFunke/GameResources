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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; META HOTKEYS (PAUSING, RESOURCE TRADING, ETC) ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;;;;; For pausing and unpausing quickly
*F5::
Send {F10}m{F10}
return

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; CTRL GROUP MANAGEMENT HOTKEYS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;;;;;; Make alt function to ADD TO hotkey groups
;;Note that we need to use ::Send here, instead of the 'remap' syntax of a::b, since remap will preserve any modifier keys held (which isn't a problem when changing shift to ctrl, since WC3 interprets Shift + Ctrl as SETTING a hotkey
Alt & 1::Send, +1
Alt & 2::Send, +2
Alt & 3::Send, +3
Alt & 4::Send, +4
Alt & 5::Send, +5
Alt & 6::Send, +6
Alt & 7::Send, +7
Alt & 8::Send, +8
Alt & 9::Send, +9
Alt & 0::Send, +0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; CTRL GROUP MANAGEMENT HOTKEYS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;Front mouse button + ability hotkeys send inventory keys
;;;;;;(Front side mouse button, which for me is Left Arrow Key for me due to Logitech Ghub)
; Arrangement is like so:
; E F
; A S
; D R
Left & E::Send, {Numpad7}
Left & A::Send, {Numpad4}
Left & D::Send, {Numpad1}
Left & F::Send, {Numpad8}
Left & S::Send, {Numpad5}
Left & R::Send, {Numpad2}
;Ensure it also works with shift-clicking to queue commands with items
+Left & E::Send, +{Numpad7}
+Left & A::Send, +{Numpad4}
+Left & D::Send, +{Numpad1}
+Left & F::Send, +{Numpad8}
+Left & S::Send, +{Numpad5}
+Left & R::Send, +{Numpad2}

;;;;;;Back mouse button + unit hotkeys send building/misc hotkeys
;;;;;;(Back side mouse button, which for me is Right Arrow Key for me due to Logitech Ghub)
Right & Space::Send, 5
Right & c::Send, 6
Right & w::Send, 7
Right & g::Send, 8
;;Ensure that it works with Shift and Ctrl for setting/adding to these hotkeys
+Right & Space::Send, +5
+Right & c::Send, +6
+Right & w::Send, +7
+Right & g::Send, +8
;;;;TODO: Does this actually work, since I don't actually use ctrl? Probably not
^Right & Space::Send, ^5
^Right & c::Send, ^6
^Right & w::Send, ^7
^Right & g::Send, ^8

;;;;;; For Heroes
c::F1
w::F2
t::F3

;;;;;; For subgroup order modifier key (useful for destro micro w/ statues and sending ghoul to lumber at start of game)
;;;;;; Use ALT or Windows key (if you miss alt)
*LAlt::
sendinput, {Ctrl Down}
keywait, LAlt
sendinput, {Ctrl Up}
return

;;;;;; Disable windows key, make it send the same thing as alt instead
*LWin::
sendinput, {Ctrl Down}
keywait, LWin
sendinput, {Ctrl Up}
return

;;;;;;; '3' is alt for beaconing purposes and alt-tab
*3::
sendinput, {Alt Down}
keywait, 3
sendinput, {Alt Up}
return

;;;;;; make mouse wheel down and up act as 'Stop' for faking abilities like coil, dagger
;;;;;; and for spamming stop on a tower to stop it from taking XP
WheelDown::
Send, m
return
WheelUp::
Send, m
return

;;;;;; Make Caps lock a usable key (without toggling your upper/lower case)
*Capslock::l

;;;;;; make mouse wheel middle button click send K for learn ability on hero (middle mouse button does not appear to be able to be bound otherwise)
MButton::
Send, k
return

;;;;;; Make DPI mouse button function as 'P' for "Hold Position", since '0' key does not seem to be able to be bound in WC3
;;;;;; Note that my Logitech GHub binds it to 0, that's why 0 is used here
;;;;;; A different key may be needed depending on your mouse settings
0::p