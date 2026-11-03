RunFFCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)j") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Down %count%}
	Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^plus$")
		Send {PgDn}
	Else If RegExMatch(key, "i)^k$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Up %count%}
	Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^plus$")
		Send {PgUp}
	Else If RegExMatch(key, "i)^l$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send ^{Tab %count%}
	Else If RegExMatch(key, "i)^h$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send ^+{Tab %count%}
	Else If RegExMatch(key, "i)^l$") && RegExMatch(modifier, "i)^plus$")
		Send ^+{PgDn %count%}
	Else If RegExMatch(key, "i)^h$") && RegExMatch(modifier, "i)^plus$")
		Send ^+{PgUp %count%}
	Else If RegExMatch(key, "i)^b$") && !RegExMatch(modifier, "i)^plus$")
		Send !{Left}
	Else If RegExMatch(key, "i)^f$") && RegExMatch(modifier, "i)^ctrl$")
	{
		Send ^f
		vi := 0
	}
	Else If RegExMatch(key, "i)^f$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send !{Right}
	Else If RegExMatch(key, "i)^u$")
		Send ^l
	Else If RegExMatch(key, "i)^x$") && !RegExMatch(modifier, "i)^plus$")
		Send ^x
	Else If RegExMatch(key, "i)^x$") && RegExMatch(modifier, "i)^plus$")
		Send ^{F4}
	Else If RegExMatch(key, "i)^r$")
		Send {F5}
	Else If RegExMatch(key, "i)^t$")
		Send ^t
	Else If RegExMatch(key, "i)^o$")
		Send {Enter}
	Else If RegExMatch(key, "i)^tab$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Tab %count%}
	Else If RegExMatch(key, "i)^tab$") && RegExMatch(modifier, "i)^plus$")
		Send +{Tab %count%}
	Else If RegExMatch(key, "i)^a$") && RegExMatch(modifier, "i)^plus$")
		Send ^a
	Else If RegExMatch(key, "i)^fSlash$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		Send /
		vi := 0
		ChangeIcons()
	}
	Else If RegExMatch(key, "i)^dot$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		Send .
		vi := 0
		ChangeIcons()
	}
	Else If RegExMatch(key, "i)^enter$")
		Send {Enter}
	Else If RegExMatch(key, "i)^q$") && RegExMatch(modifier, "i)^ctrl$")
	{
		ClickFunc(290, 640)
		Sleep, 3000
		ClickFunc(380, 240)
		Sleep, 3000
		Send {Tab 3}
		Sleep, 500
		Send {Enter}
	}
	Else If RegExMatch(key, "i)^s$") && RegExMatch(modifier, "i)^ctrl$")
		Send ^s
	Else If RegExMatch(key, "i)^s$") && RegExMatch(modifier, "i)^alt$")
	{
		Send ^s
		Sleep, 1000
		Send {Enter}
		Sleep, 1000
		Send ^{F4}
		Sleep, 400
		Send {Tab}
	}
	Else If RegExMatch(key, "i)^d$")
    {
        MouseGetPos, MouseX, MouseY
        ClickFunc(1839,65)
        Sleep, 500
        ClickFunc(MouseX,MouseY)
    }
}

; Firefox
#IfWinActive ahk_class MozillaWindowClass
$!r::
If pointNCLick != 0
{
	Send ^{F1}
	MouseMove 1014,122
	Send ^{F2}
}
Else
{
	MouseMove 1014,122
}

ClickFunc(214,122)
Sleep, 500
Send {Tab 2}
Sleep, 100
Send {Down}
Sleep, 100
Send {Tab}

vi:=0
Return

$^!h::
Send ^c
Sleep, 50
RunControlFocus("h")
Sleep, 700
Send @o
Sleep, 700
RunControlFocus("f")
Return

; function to select a textbox type in Umbraco
$^!t::
Sleep, 700
Send {Tab 4}
Sleep, 100
Send {Enter}
Sleep, 1500
Send {Tab 8}
Sleep, 100
Send {Enter}
Sleep, 1500
Send {Tab}
Sleep, 100
Send {Enter}
Sleep, 1500
Send +{Tab}
Sleep, 100
Send {Enter}
return

; extends previous function to grab text from vim then select a textbox type in Umbraco
; assumes macro f is HvEyj
$^!n::
InputBox, numOfLoops, "Number of iterations", "Enter a number"

Loop %numOfLoops%
{
	Sleep, 200
	Send {Enter}
	Sleep, 100
	RunControlFocus("h")
	Sleep, 200
	Send \qf
	Sleep, 500
	RunControlFocus("f")
	Sleep, 200
	Send ^v
	Sleep, 700
	Send {Tab 4}
	Sleep, 100
	Send {Enter}
	Sleep, 1500
	Send {Tab 8}
	Sleep, 100
	Send {Enter}
	Sleep, 1500
	Send {Tab}
	Sleep, 100
	Send {Enter}
	Sleep, 1500
	Send +{Tab}
	Sleep, 100
	Send {Enter}
	Sleep, 500
}
return

; used after prev function to fill in text to the properties we created on the content
$^!s::
; assumes macro r is
InputBox, numOfLoops, "Number of iterations", "Enter a number"

Loop %numOfLoops%
{
	Sleep, 100
	RunControlFocus("h")
	Sleep, 200
	Send \qr
	Sleep, 500
	RunControlFocus("f")
	Sleep, 200
	Send ^v
	Sleep, 100
	Send {Tab}
	Sleep, 100
}
return

; please kill this functionality; it keeps closing the browser window.
^w::
Return
