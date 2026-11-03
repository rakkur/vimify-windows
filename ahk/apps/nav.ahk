RunNavCommand(count, key, modifier)
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
}
