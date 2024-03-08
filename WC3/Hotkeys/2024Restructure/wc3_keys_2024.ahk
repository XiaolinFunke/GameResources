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

;;;COMMENTED FOR TESTING
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

;;;;As far as hand placement goes, the hand should be comfortably positioned on A, S, E, F, Spacebar. Naturally, we are going to bind as many keys as possible to keys near this
;hand placement. You will notice that all units are built with A,S,E or F. It would seem natural to also place unit/hero abilities on A, S, E, and F, as in my Dota2 keys. 
;However, in WC3, it's more important to be able to hit a hotkey + ability quickly rather than ability + ability like in dota. Thus, I used A, W, S, and D instead, and
;left E and F as hotkeys. 

;Having two abilities that are the same finger (W and S) is less of an issue in WC3 because there is usually some cast time to wait for before spamming a second ability right away anyway
;;;;Notice that none of the ability keys are hit with the pointer finger. This means that your main two ctrl groups as well as hero hotkeys will always be hit with a different
;finger than the ability you want them to do, making that fast. The same is true for the third ctrl group (E), except for the 4th ability ('D'). Most casters that I tend
;to put in ctrl group 3 have a non-time-sensitive ability in that spot for this reason
;The 'D' ability key could instead be moved such that it is hit with the pinky rather than ring finger, for example, it could be on 'Z'. However, the comfort of 'D' over 'Z', especially when
;casting multiple abilities in a row, won out
;;;;;Item hotkeys follow a similar rationale as ability hotkeys -- None of them are executed with the pointer finger, 
;since you often want to hit a hero hotkey with pointer finger and then hit an item quickly

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
;;;;;;; CTRL GROUP HOTKEYS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; Micro control groups - ensure setting them works with shift and adding with Alt
;;;; * is necessary here to preserve modifiers (whereas that happens automatically with the Key & Key combinations used in the macro ctrl groups)
*Space::SendKeyWithRemappedModifier("1")
*F::SendKeyWithRemappedModifier("2")
*E::SendKeyWithRemappedModifier("3")
*4::SendKeyWithRemappedModifier("4")
*5::SendKeyWithRemappedModifier("5")

;;;;;;Macro ctrl groups --- ensure setting them works with shift and adding with Alt
Right & Space::SendKeyWithRemappedModifier("6")
Right & T::SendKeyWithRemappedModifier("7")
Right & G::SendKeyWithRemappedModifier("8")
Right & 4::SendKeyWithRemappedModifier("9")
Right & 5::SendKeyWithRemappedModifier("0")

;;;;;; Hero hotkeys
*R::Send, {F1}
*T::Send, {F2}
*G::Send, {F3}

;;;; Since some ctrl group hotkeys are already triggered using 2 keys in combination, and 3 key combinations are not supported by autohotkey,
;;;; Use this function to have shift function as Ctrl for setting ctrl groups and Alt function as shift for Ctrl group adding
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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; INVENTORY HOTKEYS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;Front mouse button + ability hotkeys send inventory keys
;;;;;;(Front side mouse button, which for me is Left Arrow Key for me due to Logitech Ghub)
; Arrangement is like so:
; E D
; W S
; A Z
Left & E::Send, {Numpad7}
Left & W::Send, {Numpad4}
Left & A::Send, {Numpad1}
Left & D::Send, {Numpad8}
Left & S::Send, {Numpad5}
Left & Z::Send, {Numpad2}



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; MACRO MODE MDOFIER KEY ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;'Macro' mode modifier key (if confused, see hotkey explanation at the top of this script)
;;; When Back mouse button is held, Map keys to other side of the keyboard
;;; Note that not all keys actually need to be remapped, since some keys already work fine when being used for both micro and macro (like unit ability keys also being used to build units)
;;; So, for convenience, those keys are not remapped, and will just work for both micro and macro situations, whether or not the 'macro' modifier key is held
Right & E::Send, u
Right & R::Send, i
Right & F::Send, o
Right & X::Send, n


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; SIMPLE REBINDS TO GET AROUND HARD-CODED / UNBINDABLE KEYS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;; Make 3 send shift. This is useful for shift queueing attack/move/patrol commands
*3::Shift

;;;;;; Make DPI mouse button function as Tab for cycling through units / buildings
;;;;;; Note that my Logitech GHub binds it to 0, that's why 0 is used here
;;;;;; A different key may be needed depending on your mouse settings
0::Tab

;;;;;; Make mouse wheel middle button click send K to be a useable key
MButton::
Send, k
return

;;;;;; Make Caps lock a usable key (without toggling your upper/lower case)
*Capslock::l

;;;;;; Make mouse wheel down and up act as the same useable key
;;;;;; Using this for 'Stop' for faking abilities like coil, dagger
;;;;;; and for spamming stop on a tower to stop it from taking XP
WheelDown::
WheelUp::
Send, m
return

;;;;;; Make 'X' work as Alt for beaconing purposes only
X & LButton::
Send !{LButton}
return

;;;;;; Make alt function as ctrl for subgroup order modifier key (useful for destro micro w/ statues and sending ghoul to lumber at start of game)
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
