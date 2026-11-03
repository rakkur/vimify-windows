RunSlackCommand(count, key, modifier)
{
	global

	; slack
	If RegExMatch(key, "i)j") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send !{Down %count%}
	Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^plus$")
		Send {PgDn}
	Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^alt$")
		Send !+{Down}
	Else If RegExMatch(key, "i)^k$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send !{Up %count%}
	Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^plus$")
		Send {PgUp}
	Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^alt$")
		Send !+{Up}
	Else If RegExMatch(key, "i)^m") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send ^+{Space}
	Else If RegExMatch(key, "i)^fSlash$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send ^f
	Else If RegExMatch(key, "i)^x$") && RegExMatch(modifier, "i)^plus$")
		Send /leave{Enter}{Enter}
	Else If RegExMatch(key, "i)^r$") && RegExMatch(modifier, "i)^ctrl$")
    {
        Send !{Space}
        Sleep, 200
        Send x
    }
	Else If RegExMatch(key, "i)^r$")
		Send {F5}
	Else If RegExMatch(key, "i)^o$")
		Send {Enter}
	Else If RegExMatch(key, "i)^u$")
		Send ^l
	Else If RegExMatch(key, "i)^x$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send ^x
	Else If RegExMatch(key, "i)^t$")
		Send ^t
	Else If RegExMatch(key, "i)^x$") && RegExMatch(modifier, "i)^(plus)$")
		Send ^{F4}
	Else If RegExMatch(key, "i)^g$")
		Send {End}
}
