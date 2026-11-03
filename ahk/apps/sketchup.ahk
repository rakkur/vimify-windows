RunSketchupCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)^y$") ; line
		Send l
	Else If RegExMatch(key, "i)^e$") ; rectangle
		Send r
	Else If RegExMatch(key, "i)^k$") ; select
		Send {Space}
	Else If RegExMatch(key, "i)^o$") ; move
		Send m
	Else If RegExMatch(key, "i)^p$") ; tape measure
		Send t
	Else If RegExMatch(key, "i)^u$") ; push/pull
		Send p
	Else If RegExMatch(key, "i)^q$") ; push/pull
		Send q
	Else If RegExMatch(key, "i)^semicolon$") ; pan
    {
        Send h
    }
	Else If RegExMatch(key, "i)^esc$")
        Send {Esc}
	Else If RegExMatch(key, "i)^1$")
        Send 1
	Else If RegExMatch(key, "i)^2$")
        Send 2
	Else If RegExMatch(key, "i)^3$")
        Send 3
	Else If RegExMatch(key, "i)^4$")
        Send 4
	Else If RegExMatch(key, "i)^5$")
        Send 5
	Else If RegExMatch(key, "i)^6$")
        Send 6
	Else If RegExMatch(key, "i)^7$")
        Send 7
	Else If RegExMatch(key, "i)^8$")
        Send 8
	Else If RegExMatch(key, "i)^9$")
        Send 9
	Else If RegExMatch(key, "i)^0$")
        Send 0
	Else If RegExMatch(key, "i)^comma$")
        Send {,}
	Else If RegExMatch(key, "i)^quote$")
        Send {"}
	Else If RegExMatch(key, "i)^enter$")
        Send {Enter}
	Else If RegExMatch(key, "i)^dot$")
        Send {.}
	Else If RegExMatch(key, "i)^j$")
        Send {Up}
    Else
        Send {key}
}
