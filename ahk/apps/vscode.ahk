
RunVSCodeCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)^x$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send ^x
	Else If RegExMatch(key, "i)^d$")
		Send {Delete}
	Else If RegExMatch(key, "i)^a$") && RegExMatch(modifier, "i)^plus$")
		Send ^a
	Else If RegExMatch(key, "i)^h$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Left %count%}
	Else If RegExMatch(key, "i)^h$") && RegExMatch(modifier, "i)^(plus)$")
		Send {Home}
	Else If RegExMatch(key, "i)^h$") && RegExMatch(modifier, "i)^(alt)$")
		Send ^+{Tab}
	Else If RegExMatch(key, "i)^j$")
		Send {Down %count%}
	Else If RegExMatch(key, "i)^k$")
		Send {Up %count%}
	Else If RegExMatch(key, "i)^l$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Right %count%}
	Else If RegExMatch(key, "i)^l$") && RegExMatch(modifier, "i)^(plus)$")
		Send {End}
	Else If RegExMatch(key, "i)^l$") && RegExMatch(modifier, "i)^(alt)$")
		Send ^{Tab}
	Else If RegExMatch(key, "i)^enter$")
		Send {Enter}
	Else If RegExMatch(key, "i)^r$")
		Send ^+e
	Else If RegExMatch(key, "i)^t$")
		Send ^!d
	Else If RegExMatch(key, "i)^l$") && RegExMatch(modifier, "i)^(alt)$")
		Send ^{PgUp}
	Else If RegExMatch(key, "i)^h$") && RegExMatch(modifier, "i)^(alt)$")
		Send ^{PgDn}
	Else If RegExMatch(key, "i)^x$") && RegExMatch(modifier, "i)^(alt)$")
		Send !l
	Else If RegExMatch(key, "i)^tab$")
		Send {F6}
	Else If RegExMatch(key, "i)^x$") && RegExMatch(modifier, "i)^(plus)$")
		Send ^{F4}
	Else If RegExMatch(key, "i)^q$") && !RegExMatch(modifier, "i)^(plus)$")
    {
        Send {LWin down}
        Send +f
        Send {LWin up}
        Send {Tab}
    }
	Else If RegExMatch(key, "i)^q$") && RegExMatch(modifier, "i)^(plus)$")
    {
        Send {LWin down}
        Send +f
        Send {LWin up}
    }
	Else If RegExMatch(key, "i)^o$") && RegExMatch(modifier, "i)^(plus)$")
    {
        Send ^a
        Sleep, 100
        Send ^c
        Sleep, 100
        RunControlFocus("h")
        Sleep, 100
        Send :e C:\temp\tmp.sql
        Send {Enter}
        Sleep, 250
        Send ggVGpG
    }
}
