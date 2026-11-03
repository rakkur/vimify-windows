RunWordCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)^x$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send ^x
	Else If RegExMatch(key, "i)^d$")
		Send {Delete}
	Else If RegExMatch(key, "i)^a$") && RegExMatch(modifier, "i)^plus$")
		Send ^a
	Else If RegExMatch(key, "i)^enter$")
		Send {Enter}
	Else If RegExMatch(key, "i)j") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Down %count%}
	Else If RegExMatch(key, "i)k") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Up %count%}
	Else If RegExMatch(key, "i)t") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		Send !h
		Send 4
	}
	Else If RegExMatch(key, "i)^o$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		Send !n
		Send l
		toggleEditing := 1
		vi := 0
	}
    ; OpenOffice stuffs
	Else If RegExMatch(key, "i)^z$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		Send ^v
		Send {F4}
        Sleep, 300
        Send !+w
		Sleep, 50
		Send {Enter}
		Sleep, 50
		Send {Esc}
	}
	Else If RegExMatch(key, "i)^l$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		Send !o
        Sleep, 50
        Send l
        Sleep, 100
        Send ^a
        Send 2
        Send {Enter}
	}
	Else If RegExMatch(key, "i)^b$") && RegExMatch(modifier, "i)^alt$")
	{
		Send +{Down}
		Sleep, 200
		Send !a
        Sleep, 200
        Send !b
        Sleep, 200
        Send !d
        Send {Left}{Left}{Left}{Left}
		Sleep, 100
		Send {Enter}
	}
}
