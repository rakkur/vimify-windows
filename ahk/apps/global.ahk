;this one grabs a pixel color under the mouse cursor
^!z::  ; Control+Alt+Z hotkey.
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
StringTrimLeft, color, color, 2
clipboard = %color%
Return

; Function to click on a particular place on the page using our pointNCLick modifiers
ClickFunc(horizPos, vertPos)
{
	global
	If pointNCLick = 0
		Click %horizPos%, %vertPos%
	Else
		MouseMove %horizPos%, %vertPos%
}

^!p::Pause
^!a::Suspend

^!,::
if(disableCommaTab)
    disableCommaTab := 0
else
    disableCommaTab := 1
Return

; this command switches the languages around for my pc.  People keep needing to use it but I type Dvorak
^!+l::
If pointNCLick != 0
{
	Send ^{F1}
	pointNCLick := 0
	ChangeIcons()
}

toggleEditing := 1
vi := 0

InputBox, destLanguage, "Which keyboard are we changing to?", "Enter d or q: This is the destination language"

If RegExMatch(destLanguage, "i)^[dq]$")
{
    Run, C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -File "%A_ScriptDir%\scripts\changeKeyboardLayout.ps1" -layout %destLanguage%
}
Return

; functions to set/get clipboard values used by registers
GrabClipboard(arrayPoint)
{
	global

    clipboardSave := clipboard
	Sleep, 50
	Send ^c
	Sleep, 100
	registerArray%arrayPoint% := clipboard
	Sleep, 50
	clipboard := clipboardSave
	Sleep, 50
}

SendClipboard(arrayPoint)
{
	global

    clipboardSave := clipboard
	Sleep, 50
	clipboard := registerArray%arrayPoint%
	Sleep, 50
	Send ^v
	Sleep, 100
    clipboard := clipboardSave
}
