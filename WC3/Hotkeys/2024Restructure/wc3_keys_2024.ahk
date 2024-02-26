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
;;;;;;; EXPLANATION OF HOTKEYS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;These hotkeys were designed to try to limit hand movement as much as possible. To this end, it was observed that
;certain keys limit our ability to do this more than others. Namely, keys for selecting and setting ctrl groups are difficult
;to place in prime locations on the keyboard because they are not allowed to overlap with any other keys. By contrast, unit
;abilities can overlap with other unit abilities, as well as shop purchasing hotkeys, building menu hotkeys, etc., so these hotkeys
;are often much better placed

;;;;However, ctrl-group hotkeys are very important and are used often, so we want to place them in prime locations if possible
;In order to achieve this, this script allows you to hold down a modifier key that will remap certain keys. This way, you can use the same keys
;for ctrl groups that you do for other actions. You can think of this like another 'layer' of keys under the original layer

;;;;I decided to place this modifier key on the mouse for ease of use. And, in order to avoid having to switch between
;'layers' very often, which would be cumbersome, I decided to change the idea from Layer 1 being for ctrl groups and Layer 2 being for everything else
;to having a 'Macro' layer and a 'Micro' layer instead. Thus, only allowing you to change layers when switching between macro and micro tasks, in theory

;;;;The 'Micro' layer consists of 5 ctrl groups for unit control, as well as the 3 hero hotkeys. It also has unit/hero ability keys
;This layer is the default layer. No modifier key needs to be held to use it

;;;;The 'Macro' layer consists of 5 ctrl groups for building/macro control, as well as keys for the building menu, hotkeys on buildings, and buying items
;This layer is activated by holding the mouse button 'Macro layer' modifier key

;;;;Since not all key overlaps are problematic, some keys exist in both layers, and the modifier key does not affect them.
;However, I would recommend still using the modifier key as appropriate whenever the task calls for it, even if it will not affect the key being pressed
;since this is much easier to conceptualize and remember than memorizing which keys are actually affected by the 'Macro layer' modifier key



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


;;;;'Macro' mode modifier key
;;; When Back mouse button is held, Map keys to other side of the keyboard
;;; This allows us to overlap macro hotkeys with hotkeys we use for micro that we would not otherwise be able to overlap (like unit control groups overlapping with building hotkeys)
;;; Note that not all keys actually need to be remapped, since some keys already work fine when being used for both micro and macro (like unit ability keys also being used to build units)
;;; So, for convenience, those keys are not remapped, and will just work for both micro and macro situations, whether or not the 'macro' modifier key is held
Right & W::Send, u
Right & R::Send, i
Right & D::Send, o
Right & C::Send, j
;;;;;;Macro ctrl groups --- ensure setting them works with shift
;;;;;; Send blind so that modifiers will be preserved (so setting the ctrl groups will work too)
Right & Space::SendKeyWithRemappedModifier("6")
Right & T::SendKeyWithRemappedModifier("7")
Right & G::SendKeyWithRemappedModifier("8")
Right & 4::SendKeyWithRemappedModifier("9")
Right & Y::SendKeyWithRemappedModifier("0")

;;;; Micro control groups - ensure setting them works with shift
;;;; * is necessary here to preserve modifiers (whereas that happens automatically with the Key & Key combinations above)
*Space::SendKeyWithRemappedModifier("1")
*C::SendKeyWithRemappedModifier("2")
*W::SendKeyWithRemappedModifier("3")
*T::SendKeyWithRemappedModifier("4")
*Y::SendKeyWithRemappedModifier("5")

;;;; Since some ctrl group hotkeys are already triggered using 2 keys in combination, and 3 key combinations are not supported by autohotkey,
;;;; Use this function to have shift function as Ctrl for setting ctrl groups
SendKeyWithRemappedModifier(keyToSend)
{
  if (GetKeyState("Shift")) or (GetKeyState("Shift"), "P") {
    ;;;; Don't need to release shift, since, in WC3, Shift + Ctrl + hotkey SETS the control group rather than adding to it (unlike in dota2)
    Send ^%keyToSend%
  }
  else if (GetKeyState("Alt")) or (GetKeyState("Alt"), "P") {
    Send +%keyToSend%
  }
  else
  {
    Send, {Blind}%keyToSend%
  }
}

;;;;;; For subgroup order modifier key (useful for destro micro w/ statues and sending ghoul to lumber at start of game)
;;;;;; Use ALT or Windows key (if you miss alt)
;*LAlt::
;sendinput, {Ctrl Down}
;keywait, LAlt
;sendinput, {Ctrl Up}
;return

;Make alt function as ctrl for subgroup order modifier key
!RButton::
Send ^{RButton}
return
;;;;;; Make Alt function as Ctrl for Ctrl-clicking to select multiple units
!LButton::
Send ^{LButton}
return


;;;;;; Alias windows key to Alt
;Use remap syntax instead of Send so that it will trigger hotkeys that normally trigger with Alt
LWin::LAlt
;;;;;; Disable windows key, make it send the same thing as alt instead
;*LWin::
;sendinput, {Ctrl Down}
;keywait, LWin
;sendinput, {Ctrl Up}
;return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; CTRL GROUP MANAGEMENT HOTKEYS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;; Make alt function to ADD TO hotkey groups
;;;;;;; Use remap syntax (x::y) so that Holding alt to add to the group won't toggle your health bars off
;; Doesn't work because Alt is also functioning as Ctrl, so it will SET the hotkey
!1::+1
;!2::+2
;!3::+3
;!4::+4
;!5::+5
;!6::+6
;!7::+7
;!8::+8
;!9::+9
;!0::+0
;!Tab::!Tab
;Alt & 3::Send, +3
;Alt & 2::Send, +2
;Alt & 4::Send, +4
;Alt & 5::Send, +5
;Alt & 6::Send, +6
;Alt & 7::Send, +7
;Alt & 8::Send, +8
;Alt & 9::Send, +9
;Alt & 0::Send, +0

;Alt & 2::SendWithShiftButNotCtrlHeld("2")

;;;; Use this function to have alt function as shift for adding to ctrl groups
;SendWithShiftButNotCtrlHeld(keyToSend)
;{
;  if (GetKeyState("Ctrl")) or (GetKeyState("Ctrl"), "P") {
;    ;;;; Must release Ctrl, since Shift + Ctrl + hotkey SETS the control group rather than adding to it (unlike in dota2)
;    Send {Ctrl Up}
;	Send +%keyToSend%
;	Send {Ctrl Down}
 ; }
 ; else
 ; {
 ;   Send, +%keyToSend%
 ; }
;}





;;;;;; Hero hotkeys
*R::Send, {F1}
*D::Send, {F2}
*G::Send, {F3}

;;;;;;; '3' is alt for beaconing purposes only
3 & LButton::
Send !{LButton}
return

;*3::
;sendinput, {Alt Down}
;keywait, 3
;sendinput, {Alt Up}
;return
;;;;Since Alt is functioning as Ctrl, use 3 + Tab to alt tab instead
;3 & Tab::Send, {AltTab}


;;;;;; make mouse wheel down and up act as 'Stop' for faking abilities like coil, dagger
;;;;;; and for spamming stop on a tower to stop it from taking XP
WheelDown::
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