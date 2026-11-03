; almost same as ff.
RunIECommand(count, key, modifier)
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
	Else If RegExMatch(key, "i)^l$")
		Send ^{Tab %count%}
	Else If RegExMatch(key, "i)^h$")
		Send ^+{Tab %count%}
	Else If RegExMatch(key, "i)^b$") && !RegExMatch(modifier, "i)^plus$")
		Send !{Left}
	Else If RegExMatch(key, "i)^f$")
		Send !{Right}
	Else If RegExMatch(key, "i)^u$")
		Send !d
	Else If RegExMatch(key, "i)^x$") && !RegExMatch(modifier, "i)^plus$")
		Send ^x
	Else If RegExMatch(key, "i)^x$") && RegExMatch(modifier, "i)^plus$")
		Send ^{F4}
	Else If RegExMatch(key, "i)^r$")
		Send {F5}
	Else If RegExMatch(key, "i)^t$")
		Send ^t
	Else If RegExMatch(key, "i)^q$")
		Send {Tab}
	Else If RegExMatch(key, "i)^o$")
		Send {Enter}
	Else If RegExMatch(key, "i)^tab$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Tab %count%}
	Else If RegExMatch(key, "i)^tab$") && RegExMatch(modifier, "i)^plus$")
		Send +{Tab %count%}
	Else If RegExMatch(key, "i)^a$") && RegExMatch(modifier, "i)^plus$")
		Send ^a
	Else If RegExMatch(key, "i)^enter$")
		Send {Enter}
}

#IfWinActive ahk_class IEFrame
$F5::
Return
