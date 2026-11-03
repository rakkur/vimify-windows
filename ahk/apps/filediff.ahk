RunFileDiffCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)plus")
		Send {PgDn}
	Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)plus")
		Send {PgUp}
	Else If RegExMatch(key, "i)^h$")
		Send {Left %count%}
	Else If RegExMatch(key, "i)^l$")
		Send {Right %count%}
	Else If RegExMatch(key, "i)^j$")
		Send {Down %count%}
	Else If RegExMatch(key, "i)^k$")
		Send {Up %count%}
	Else If RegExMatch(key, "i)^n$") ;next window
		Send ^{Tab %count%}
	Else If RegExMatch(key, "i)^o$") ;mark left side as correct
		Send ^{1}
	Else If RegExMatch(key, "i)^p$") ;mark right side as correct
		Send ^{2}
	Else If RegExMatch(key, "i)^s$") ;save
		Send ^s
	Else If RegExMatch(key, "i)^m$") ;open code compare
    {
        Sleep, 300
        Send {Alt}
        Send {Right 5}
        Sleep, 100
        Send {Enter}
        Sleep, 100
        Send {Up 1}
        Sleep, 100
        Send {Enter}
        Sleep, 100
    }
	Else If RegExMatch(key, "i)^d$") && RegExMatch(modifier, "i)plus") ;prev error
		Send ^{Up}
	Else If RegExMatch(key, "i)^d$") ;next error
		Send ^{Down}
	Else If RegExMatch(key, "i)^i$") && RegExMatch(modifier, "i)alt") ;show individual files
    {
        Sleep, 300
        Send !d
        Send {Down 11}
        Send {Enter}
    }
}
