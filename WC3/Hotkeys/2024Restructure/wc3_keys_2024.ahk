#SingleInstance force		;force a single instance
#HotkeyInterval 0		;disable the warning dialog if a key is held down
#InstallKeybdHook		;Forces the unconditional installation of the keyboard hook
#UseHook On			;might increase responsiveness of hotkeys. Beware: By default, hotkeys that use the keyboard hook cannot be triggered by means of the Send command
#MaxThreads 20			;use 20 (the max) instead of 10 threads
SetBatchLines, -1		;makes the script run at max speed
SetKeyDelay , -1, -1		;faster response (might be better with -1, 0)

;;;;; Make the icon the TFT icon (Author: NiJo?) ;;;;;  
regread, war, HKEY_CURRENT_USER, Software\Blizzard Entertainment\Warcraft III, ProgramX
menu, tray, Icon, %War%, 1, 1 

#ifWinActive, ahk_exe Warcraft III.exe ;Only run when wc3 window is active

;;;;; Configurable Variables ;;;;;
;;; Due to Logitech GHub, some of my mouse buttons send non-standard keys when pressed 
;;; This may or may not be the case for you -- modify these variables to reflect the keys your mouse sends
;;; Need quotes around these because some of them are used in key combinations (%var% & Y)
FrontMouseButtonKey := "Left"  ;Standard key would be XButton2 - This is referring to the side mouse button that is farther from the palm of the hand
BackMouseButtonKey := "Right"  ;Standard key would be XButton1 - This is referring to the side mouse button that is closer to the palm of the hand
DPIMouseButtonKey := "0"    
MouseWheelClick := "MButton"
MouseWheelScrollUp := "WheelUp"
MouseWheelScrollDown := "WheelDown"

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

;;;;I decided to place this modifier key on the mouse for ease of use. And, in order to avoid having to switch back and forth between
;'layers' very often or mid-task, which would be cumbersome, I decided to change the idea from Layer 1 being for ctrl groups and Layer 2 being for everything else
;to having a 'Macro' layer and a 'Micro' layer instead. Thus, requiring you to change layers only when switching between macro and micro tasks

;;;;The 'Micro' layer consists of 5 ctrl groups for unit control, as well as the 3 hero hotkeys. It also has unit/hero ability keys
;This layer is the default layer. No modifier key needs to be held to use it

;;;;The 'Macro' layer consists of 5 ctrl groups for building/macro control, as well as keys for the building menu, hotkeys on buildings, and buying items
;This layer is activated by holding the mouse button 'Macro layer' modifier key

;;;;Since not all key overlaps are problematic, some keys exist in both layers, and the modifier key does not affect them.
;However, I would recommend still using the modifier key as appropriate whenever the task calls for it, even if it will not affect the key being pressed
;since this is much easier to conceptualize and remember than memorizing which keys are actually affected by the 'Macro layer' modifier key

;;;;As far as hand placement goes, the hand should be comfortably positioned on A, S, E, F, Spacebar. Naturally, we are going to bind as many keys as possible to keys near this
;hand placement. You will notice that all units are built with A,S,E or F. It would seem natural to also place unit/hero abilities on A, S, E, and F, as in my Dota2 keys. 
;However, in WC3, it's more important to be able to hit a hotkey + ability quickly rather than ability + ability like in dota. Thus, I used A, W, S, and D for abilities instead, and
;left E and F as hotkeys. 
;Having two abilities that are the same finger (W and S) is less of an issue in WC3 because there is usually some cast time to wait for before spamming a second ability right away anyway

;;;;Notice that none of the ability keys are hit with the pointer finger. This means that your main two ctrl groups as well as hero hotkeys will always be hit with a different
;finger than the ability you want them to do, making that fast. The same is true for the third ctrl group ('E'), except for when using a unit's 4th ability ('D'). Most casters that I tend
;to put in ctrl group 3 have a non-time-sensitive ability (or no ability) in that spot for this reason
;The 'D' ability key could instead be moved such that it is hit with the pinky rather than ring finger, for example, it could be on 'Z'. However, the comfort of 'D' over 'Z', especially when
;casting multiple abilities in a row, made 'D' win out over 'Z'

;;;;;Item hotkeys follow a similar rationale as ability hotkeys -- None of them are executed with the pointer finger, 
;since you often want to hit a hero hotkey with pointer finger and then hit an item quickly

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; BEGIN MAIN SECTION OF SCRIPT ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;; Other Variables ;;;;;
InChatRoomOn := False
InResourceMenu := False

;;;;; HotKey commands ;;;;;
;HotKey commands must be placed at the top of the script (in the script's auto-execute section)
;HotKey command is used in these cases rather than more conventional remapping techniques, since we need the triggering key to be a variable
;Most of these HotKey commands have been placed into functions so that they can exist in a spot in the script where they make sense
;rather than needing to be placed up top. They will instead be called up here through the use of those functions
HotKey, %DPIMouseButtonKey%, DPIMouseButtonHandler
HotKey, %MouseWheelClick%, MouseWheelClickHandler
HotKey, %MouseWheelScrollUp%, MouseWheelScrollUpHandler
HotKey, %MouseWheelScrollDown%, MouseWheelScrollDownHandler
setMacroCtrlGroupHotkeys()
setMacroModeRemappings()
setInventoryHotkeys()

;;;;;;; END AUTO-EXECUTE SECTION OF SCRIPT ;;;;;;

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
*6::
Send {F10}m{F10}
return

;;;;;; For resource trading - Y instead of F11. Y also closes the menu (usually it would just open it and enter to close)
*Y::
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
*Space::sendKeyWithRemappedModifier("1")
*F::sendKeyWithRemappedModifier("2")
*E::sendKeyWithRemappedModifier("3")
*4::sendKeyWithRemappedModifier("4")
*5::sendKeyWithRemappedModifier("5")

;;;;;;Macro ctrl groups --- Accessed through use of 'Macro Mode' modifier key (Back mouse button) --- ensure setting them works with shift and adding with Alt
setMacroCtrlGroupHotkeys()
{
  Global BackMouseButtonKey
  HotKey, %BackMouseButtonKey% & Space, MacroHotkey1Handler
  HotKey, %BackMouseButtonKey% & T, MacroHotkey2Handler
  HotKey, %BackMouseButtonKey% & G, MacroHotkey3Handler
  HotKey, %BackMouseButtonKey% & 4, MacroHotkey4Handler
  HotKey, %BackMouseButtonKey% & 5, MacroHotkey5Handler
}
MacroHotkey1Handler:
sendKeyWithRemappedModifier("6")
return
MacroHotkey2Handler:
sendKeyWithRemappedModifier("7")
return
MacroHotkey3Handler:
sendKeyWithRemappedModifier("8")
return
MacroHotkey4Handler:
sendKeyWithRemappedModifier("9")
return
MacroHotkey5Handler:
sendKeyWithRemappedModifier("0")
return

;;;;;; Hero hotkeys
*R::Send, {F1}
*T::Send, {F2}
*G::Send, {F3}

;;;; Since some control group hotkeys are already triggered using 2 keys in combination, and 3 key combinations are not supported by autohotkey,
;;;; use this function to have shift function as Ctrl for setting control groups and Ctrl (and Alt, since it's aliased to Ctrl) function as shift for Ctrl group adding
sendKeyWithRemappedModifier(keyToSend)
{
  if (GetKeyState("Shift")) or (GetKeyState("Shift"), "P") {
    ;;;; Don't need to release shift, since, in WC3, Shift + Ctrl + hotkey SETS the control group rather than adding to it (unlike in dota2)
    Send ^%keyToSend%
  }
  else if (GetKeyState("Ctrl")) or (GetKeyState("Ctrl"), "P") {
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
; Arrangement is like so:
; E D
; W S
; A Z
setInventoryHotkeys()
{
  Global FrontMouseButtonKey
  HotKey, %FrontMouseButtonKey% & E, Inventory1Handler
  HotKey, %FrontMouseButtonKey% & D, Inventory2Handler
  HotKey, %FrontMouseButtonKey% & W, Inventory3Handler
  HotKey, %FrontMouseButtonKey% & S, Inventory4Handler
  HotKey, %FrontMouseButtonKey% & A, Inventory5Handler
  HotKey, %FrontMouseButtonKey% & Z, Inventory6Handler
}
Inventory1Handler:
Send, {Numpad7}
return
Inventory2Handler:
Send, {Numpad8}
return
Inventory3Handler:
Send, {Numpad4}
return
Inventory4Handler:
Send, {Numpad5}
return
Inventory5Handler:
Send, {Numpad1}
return
Inventory6Handler:
Send, {Numpad2}
return



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; MACRO MODE MDOFIER KEY ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;'Macro' mode modifier key (if confused, see hotkey explanation at the top of this script)
;;; When Back mouse button is held, Map keys to other side of the keyboard
;;; Note that not all keys actually need to be remapped, since some keys already work fine when being used for both micro and macro (like unit ability keys also being used to build units)
;;; So, for convenience, those keys are not remapped, and will just work for both micro and macro situations, whether or not the 'macro' modifier key is held
setMacroModeRemappings()
{
  Global BackMouseButtonKey
  HotKey, %BackMouseButtonKey% & E, MacroEHandler
  HotKey, %BackMouseButtonKey% & R, MacroRHandler
  HotKey, %BackMouseButtonKey% & F, MacroFHandler
  HotKey, %BackMouseButtonKey% & X, MacroXHandler
}
MacroEHandler:
Send, u
return
MacroRHandler:
Send, i
return
MacroFHandler:
Send, o
return
MacroXHandler:
Send, n
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; SIMPLE REBINDS TO GET AROUND HARD-CODED / UNBINDABLE KEYS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;; Make 3 send shift. This is useful for shift queueing attack/move/patrol commands
*3::Shift

;;;;;; Make DPI mouse button function as Tab for cycling through units / buildings
DPIMouseButtonHandler:
Send {Tab}
return

;;;;;; Make pushing in the mouse wheel (mouse wheel 'click') send K, so it is a useable key
MouseWheelClickHandler:
Send, k
return

;;;;;; Make Caps lock a usable key (without toggling your upper/lower case)
*Capslock::l

;;;;;; Make mouse wheel down and up act as the same useable key
;;;;;; Using this for 'Stop' for faking abilities like coil, dagger
;;;;;; and for spamming stop on a tower to stop it from taking XP
MouseWheelScrollUpHandler:
MouseWheelScrollDownHandler:
Send, m
return

;;;;;; Make 'X' work as Alt for beaconing purposes only
X & LButton::
Send !{LButton}
return

;;;;;; Alias windows key and Alt to ctrl
;;;;;; This allows for the use of Alt for subgroup order modifier key and Ctrl-clicking to select all of a unit type, but also 
;;;;;; ensures that holding alt to use those functions won't toggle the health bars
;;;;;; Recall that Ctrl and shift have swapped roles for hotkey setting / adding, so Alt will now be functioning to ADD to a hotkey, but also
;;;;;; for the subgroup order modifier key and ctrl-clicking
;;;;;; (which is why we don't just do Alt -> Shift directly, since subgroup order modifier key and ctrl-clicking are hardcoded to Ctrl)
;;;;;;Use remap syntax instead of Send so that it will trigger hotkeys that normally trigger with Ctrl
LAlt::LCtrl

;Terminate IfWinActive condition, so this hotkey works even when alt-tabbing (the WC3 window will stop being active when alt-tabbing)
;Have it only active when WC3 is open (even if inactive) instead
#IfWinActive
#IfWinExist, ahk_exe Warcraft III.exe
;Windows key functions as Alt -- needed for Alt-Tabbing
LWin::LAlt

;;;;;;Ensure Alt-Tab works by setting Ctrl-Tab to also do Alt-Tab
;;;;;;Have to do AltTabMenu here rather than AltTab, or it will only trigger with Ctrl itself for some reason
;But AltTabMenu isn't really what we want, since it keeps the tabs up unless you click one or hit enter
;<^Tab::AltTab


;<^Tab::
;{
;Send {LAlt Down}{Tab}
;KeyWait, LCtrl
;Send {LAlt Up}
;}
;return