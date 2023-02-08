Keys and Screenshots updated as of 02/04/2023:

HOW TO SET UP HOTKEYS

1. Download the .ahk script from this repo
2. In Dota, open your options and change them to match the screenshots shown in the .png files
	-Note: These png files are annotated as follows
		-In Red:
			Some keys are triggered through the Autohotkey script, so the keys you will be *actually* hitting are annotated in red next to the keys dota thinks you are hitting. This annotation is purely informational; for the purposes of setting up your hotkeys, you can ignore the red text and just enter the hotkey as it appears in the white text
		-In Purple:
			Some of my mouse buttons are remapped using my Logitech software. Since your mouse software probably isn't set up the same way, I have annotated in purple what the *actual* hotkey is. So, your white hotkey text may need to look different than mine in order to map your mouse buttons correctly. If instead  you want to just use the same mouse mapping I use in whatever mouse software you have (this will mean you won't have to modify the .ahk script at all), it's set up like this:
			Left Side Mouse Button: LEFT arrow key
			Right Side Mouse Button: RIGHT arrow key
			DPI button: 0  (and does not change the DPI)
3. If your mouse software options are NOT the same as mine, as detailed above in step 2, you will need to modify the .ahk script slightly. Open the script and Replace every instance of "Left" and "Right" with the keys your mouse actually sends when hitting your front side mouse button and back side mouse button, respectively




BRYAN'S HOTKEY SCHEME EXPLAINED:

BACK SIDE MOUSE BUTTON:
(Mapped to Ctrl via AHK script)
Hold back mouse button to learn new abilities on level-up


FRONT SIDE MOUSE BUTTON:
(Mapped to alt via in-game hotkeys)
Can use for pinging (map and hero is missing), changing map hero icons, seeing creep boxes/tower radius (or can use Z for those, may be more comfortable)
Hold front mouse button to self-cast items and abilities (faster than double-tapping)
Hold front mouse button and hit an ability to auto-cast it (if it can be autocast)


UNIT HOTKEYS:
Hotkey1 (main hero): Space
Hotkey2: C
Hotkey3: W
Use G for select all units

Set via Shift + that hotkey


LOCATION HOTKEYS:
Hotkey1 (Top lane): Alt + W
Hotkey2 (Bottom lane): Alt + G
Hotkey3 (Mid lane): Alt + C
Hotkey4 (Rosh/Misc): Alt + 3

Set using Ctrl (or Back mouse button) + Alt + key



INVENTORY KEYS:
Inventory keys are mapped (via AHK) as the same keys as hero abilities, but while holding alt. They are set up like this:

Inventory:
Alt + A   |   Alt + S   |   Alt + E
Alt + F   |   Alt + D   |   Alt + R

Neutral Item active is Alt + T


EASY SHIFT-ATK-MOVE:
For some heroes, like Enigma, it may be necessary to shift-queue atk-move commands.
For this, I've used AHK to map '4' to 'Shift'. 4 + Capslock is much easier to hit than Shift + Capslock



CTRL-CLICKING AND SUBGROUP-ORDER MODIFIER KEY
Using AHK, I've mapped Alt to function as Ctrl for Ctrl-clicking and use of subgroup-order modifier key, since alt is easier to hit for me




WINDOWS KEY:
I've mapped Windows key to alt, so it isn't accidentally hit



CAPS LOCK:
I've mapped Capslock to M (used as atk). This ensures it is a usable key without toggling your capslock all the time'



Z AS ALT:
I've also mapped Z to alt in the AHK, so there are two options for alt, depending on what is more comfortable in a given situation (front side mouse button, or Z)