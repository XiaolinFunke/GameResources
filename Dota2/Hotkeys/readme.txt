Keys and Screenshots updated as of 02/04/2023:

HOW TO SET UP HOTKEYS

1. Download the .ahk script from this repo
2. In Dota, open your options and change them to match the screenshots shown in the .png files
	-Note: These png files are annotated as follows
		-In Red:
			Some keys are triggered through the Autohotkey script, so the keys you will be *actually* hitting are annotated in red next to the keys dota thinks you are hitting. This annotation is purely informational; for the purposes of setting up your hotkeys, you can ignore the red text and just enter the hotkey as it appears in the white text
		-In Purple:
			Some of my mouse buttons are remapped using my Logitech software. Since your mouse software probably isn't set up the same way, I have annotated in purple what the *actual* hotkey you will hit is and crossed out the white one that dota shows, since, if your mouse software is set up differently, your white text will look different than mine. If you want to just use the same mouse mapping I use in whatever mouse software you have (this will mean you won't have to modify the .ahk script at all), it's set up like this:
			Left Side Mouse Button: LEFT arrow key
			Right Side Mouse Button: RIGHT arrow key
			DPI button: 0  (and does not change the DPI)
		-In Pink:
			Optional settings that I do not use, but new players may want
3. If your mouse software options are NOT the same as mine, as detailed above in step 2, you will need to modify the .ahk script slightly. Open the script and Replace every instance of "Left" and "Right" with the keys your mouse actually sends when hitting your front side mouse button and back side mouse button, respectively


OPTIONS BRYAN CHANGES FOR SPECIFIC HEROES:
The options in the screenshots are the settings I use in general, but there are some that I change for certain heroes only. Those are noted here. Any changes here that fall under 'Unit Specific Hotkeys' will only have to be changed once and can be kept, since they don't affect other heroes, but unfortunately, any other options changes will have to be manually changed when playing the hero and then changed back afterward:
Tinker: 
	-Check 'enable Quickcast' under 'ITEMS' in Basic Hotkeys
	-Also, enable quickcast for Tinker's spells under his 'Unit Specific Hotkeys'
		-This is important to be able to cast all of Tinker's stuff quickly and then rearm
Puck: 
	-Uncheck "Channeled Abilities Requie Hold/Stop" in Basic Options
		-This is necessary in order to blink out of phase shift (very important for Puck's survivability)
Meepo:
	-Enable Quickcast for 'Poof' ability under his 'Unit Specific Hotkeys'
		-This is necessary for quickly poofing all Meepos to one spot, and for comboing with blink dagger

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