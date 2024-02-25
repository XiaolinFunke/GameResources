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
#ifWinActive, Dota 2

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



;;;;;;; Make alt function for use with inventory keys (can't use alt in game because it's hard-coded to beacon)
;Note, we can't use Ctrl either, since observer wards have a different function when ctrl is held
;Using remap syntax so that keyup and keydown are separate events (useful for quickcast on keyup)
*!a::u
*!s::i
*!e::o
*!f::j
*!d::k
*!r::l
*!t::,

;;;;;; Make Caps lock a usable key (without toggling your upper/lower case)
*Capslock::m

;;;;;; Make 4 send shift. This is useful for queueing attack move commands, such as when making summons go push out a lane
*4::Shift

;;;;;; Alias windows key to Alt
;Use remap syntax instead of Send so that it will trigger hotkeys that normally trigger with Alt
LWin::LAlt

;;;;;; Make shift function as ctrl for control group setting only
+Space::Send, ^{Space}
+c::Send, ^c
+w::Send, ^w
+4::Send, ^4
+v::Send, ^v

;;;;;;; Make ctrl + hotkeys function as "select allies" for moving camera to other lanes quickly
^Space::Send, 7
^c::Send, 8
^w::Send, 9


;;;;NO LONGER USED - I never use adding to control groups in Dota anyway, and this way I can use it for moving camera to allies instead 
;;;;;;; Make ctrl function as shift for adding to control groups only
;Note that we need to use ::Send here, instead of the 'remap' syntax of a::b, since remap will preserve any modifier keys held
;^Space::Send, +{Space}
;^c::Send, +c
;^w::Send, +w
;^4::Send, +4
;^v::Send, +v

;;;;;; Make Z send Alt Modifier (Front side mouse button, which for me is Left Arrow Key due to Logitech Ghub)
z::Left

;;;;;; Make back side mouse button function as Ctrl
;;;;;; Note that my Logitech GHub binds it to Right, that's why Right is used here
;;;;;; A different key may be needed depending on your mouse settings
Right::Ctrl


;Make alt function as ctrl for subgroup order modifier key
;Don't use on my old laptop, since it can make spamming right click and items would sometimes use the item with ctrl (which will high five if in first slot)
;Not sure why this was only an issue on there, even with the mechanical keyboard plugged in
!RButton::
Send ^{RButton}
return

;;;;;; Make Alt function as Ctrl for Ctrl-clicking to select multiple units only
!LButton::
Send ^{LButton}
return