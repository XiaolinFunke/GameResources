#if WinActive("ahk_exe FortniteClient-Win64-Shipping.exe") ;Only run when fortnite window is active

;;This script is deprecated now that Fortnite has a "Simple Edit" option that makes these not necessary. The only other change that would be needed is the Caps Lock one, but I don't type in fortnite anyway, so it's not a huge deal to not have that

;;;;;; release to edit ;;;;;;;
; XButton2 is the pysical button I press (front mouse button)
; y is my in-game edit hotkey (actually my alternate one in case I want to tap to edit)
*Left::
sendinput, l
keywait, Left
sendinput, l
return

;To make capslock a usable key without toggling caps lock
*CapsLock::
sendinput, m
return

;To reset edits with middle mouse button
*MButton::
sendinput, k
Sleep, 100
sendinput, k
return