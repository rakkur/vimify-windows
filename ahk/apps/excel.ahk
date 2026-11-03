RunXlsCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)j") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Down %count%}
	Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^plus$")
		Send {PgDn}
	Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^alt$")
		Send +{Down}
	Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^ctrl$")
		Send ^{Down}
	Else If RegExMatch(key, "i)^k$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Up %count%}
	Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^plus$")
		Send {PgUp}
	Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^alt$")
		Send +{Up}
	Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^ctrl$")
		Send ^{Up}
	Else If RegExMatch(key, "i)^l$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Right %count%}
	Else If RegExMatch(key, "i)^l$") && RegExMatch(modifier, "i)^plus$")
		Send ^+{Tab}
	Else If RegExMatch(key, "i)^h$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Left %count%}
	Else If RegExMatch(key, "i)^h$") && RegExMatch(modifier, "i)^plus$")
		Send ^{Tab}
	Else If RegExMatch(key, "i)^x$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send ^x
	Else If RegExMatch(key, "i)^d$")
		Send {Delete}
	Else If RegExMatch(key, "i)^a$") && RegExMatch(modifier, "i)^plus$")
		Send ^a
	Else If RegExMatch(key, "i)^enter$")
		Send {Enter}
	Else If RegExMatch(key, "i)^t$") ; run a macro
	{
		Send +{Space}
		Send ^c
		Send ^{Tab}
		Send ^v
		Send {Down}
		Send ^{Tab}
		Send {Down}
	}
	Else If RegExMatch(key, "i)^f") && RegExMatch(modifier, "i)^ctrl")
		Send ^f
}

#IfWinActive ahk_class XLMAIN
$^!t::
Send ^c
Sleep, 150
Send { Down }
Sleep, 150
Send !{ Tab }
Sleep, 200
Send ^v
Sleep, 200
Send { Enter }
Sleep, 200
Send !{ Tab }
Return
