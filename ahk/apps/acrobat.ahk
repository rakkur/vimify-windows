RunAcrobatCommand(count, key, modifier)
{
	If RegExMatch(key, "i)^j$") && !RegExMatch(modifier, "i)^(plus|alt|ctrl)$")
		Send {Down}
	Else If RegExMatch(key, "i)^k$") && !RegExMatch(modifier, "i)^(plus|alt|ctrl)$")
		Send {Up}
}
