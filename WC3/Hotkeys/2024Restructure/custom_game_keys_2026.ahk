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

;;;;; Prevent both scripts from running at the same time
MainKeysScriptPath := A_ScriptDir "\wc3_keys_2024.ahk"				

; Detect hidden windows so we can grab the .ahk running in the background
DetectHiddenWindows, On
; Add ahk_class Autohotkey so it won't also close the file open in an editor like notepad++
if WinExist(MainKeysScriptPath " ahk_class AutoHotkey")
	WinClose

;;;;; Only run when wc3 window is active or w3Champions window is active
#if WinActive("ahk_exe Warcraft III.exe") || WinActive("ahk_exe W3Champions.exe") 

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
;;;; These hotkeys are like the normal ones, but don't remap keys that would be problematic for Custom Games
;;;; For example, strip away the custom ctrl groups setting and macro modifier stuff. Also, anything that rebinds to
;;;; a key that is specific to my customkeys, like L
;;;; But still useful to have some keys bound, like inventory hotkeys, which don't get in the way for CGs, since you 
;;;; need to press the front mouse button to trigger them anyway
;;;; We will also do away with having to turn the keys on and off, since that should not be necessary if the keys
;;;; are truly not getting in the way of the normal keyboard buttons (which should be the case to work with whatever
;;;; keybindings custom games might have). Not having this on/off and the accompanying sound also helps to clue the user
;;;; in to whether they have the customkeys or the regular keys .ahk script turned on

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; BEGIN MAIN SECTION OF SCRIPT ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;; HotKey commands ;;;;;
;HotKey commands must be placed at the top of the script (in the script's auto-execute section)
;HotKey command is used in these cases rather than more conventional remapping techniques, since we need the triggering key to be a variable
;Most of these HotKey commands have been placed into functions so that they can exist in a spot in the script where they make sense
;rather than needing to be placed up top. They will instead be called up here through the use of those functions
;No asterisk for MouseWheelClick, so Alt/Ctrl/Shift + Mouse Wheel Click will be camera grip as normal
HotKey, %MouseWheelClick%, MouseWheelClickHandler
setInventoryHotkeys()
setCameraHotkeys()

;;;;;;; END AUTO-EXECUTE SECTION OF SCRIPT ;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; META HOTKEYS (SOUND) ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;; No need to disable/enable hotkeys like the regular script, but having some indicator the script is running is still good
;;;;; Make the sound slightly different from the normal script so we can tell which one it is
*Pause::
SoundPlay,*-1
Sleep 150
SoundPlay,*-1
Sleep 150
SoundPlay,*-1
return

*Home::
SoundPlay,*-1
Sleep 150
SoundPlay,*-1
Sleep 150
SoundPlay,*-1
return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; INVENTORY HOTKEYS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;Front mouse button + keys send inventory keys
; Arrangement is like so (keys that correspond to position in inventory):
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
;;;;;;; CAMERA HOTKEYS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;Front mouse button will also be used for the two camera-moving hotkeys
;Which are cycle through town halls and go to last alert

setCameraHotkeys()
{
  Global FrontMouseButtonKey
  HotKey, %FrontMouseButtonKey% & C, CycleTownHallHandler
  HotKey, %FrontMouseButtonKey% & V, GoToLastAlertHandler
}
CycleTownHallHandler:
Send, {Backspace}
return
GoToLastAlertHandler:
Send, {Space}
return

;;;;;; Make BMB + 3 send ` for selecting idle worker
;Note that backtick must be escaped with another backtick to register properly with Autohtokey
Macro3Handler:
Send, "``"
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; SIMPLE REBINDS TO GET AROUND HARD-CODED / UNBINDABLE KEYS ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;; Make pushing in the mouse wheel send tab
MouseWheelClickHandler:
Send {Tab}
return

;;;;;; Alias windows key and Alt to ctrl
;;;;;; This allows for the use of Alt for subgroup order modifier key and Ctrl-clicking to select all of a unit type, but also 
;;;;;; ensures that holding alt to use those functions won't toggle the health bars
;;;;;; Recall that Ctrl and shift have swapped roles for hotkey setting / adding, so Alt will now be functioning to ADD to a hotkey, but also
;;;;;; for the subgroup order modifier key and ctrl-clicking
;;;;;; (which is why we don't just do Alt -> Shift directly, since subgroup order modifier key and ctrl-clicking are hardcoded to Ctrl)
;;;;;;Use remap syntax instead of Send so that it will trigger hotkeys that normally trigger with Ctrl
LAlt::LCtrl

;Replace If WinActive condition with If WinExist condition, so this hotkey works even when alt-tabbing (the WC3 window will stop being active when alt-tabbing)
;Require WC3 or W3Champs to just be open instead
#If WinExist("ahk_exe Warcraft III.exe") || WinExist("ahk_exe W3Champions.exe")  
;;;;;;Windows key functions as Alt -- needed for Alt-Tabbing
LWin::LAlt
#If WinActive("ahk_exe Warcraft III.exe") || WinActive("ahk_exe W3Champions.exe") ;Re-instate if WinActive condition -- necessary since a lot of the hotkeys are done with handlers that still need to fire conditionally