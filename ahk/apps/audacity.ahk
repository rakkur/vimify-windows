RunAudacityCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)^f$") && !RegExMatch(modifier, "i)^(plus|alt|ctrl)$")
	{
		Send !f
		Send i
		Send a
	}
	Else If RegExMatch(key, "i)^l$")
	{
		Send !c
		Send { Down  11 }
		Send { Enter }
		Sleep, 100
	}
	Else If RegExMatch(key, "i)^o$")
	{
		Send !c
		Send { Down  12 }
		Send { Enter }
		Sleep, 100
	}

	Else If RegExMatch(key, "i)^v$") && RegExMatch(modifier, "i)plus")
	{
		Send !c
		Send { Down  1 }
		Send { Enter }
		Sleep, 100
		Send -1.0
		Send {Enter}
	}
	Else If RegExMatch(key, "i)^v$")
	{
		Send !c
		Send { Down  1 }
		Send { Enter }
		Sleep, 100
		Send 1.0
		Send {Enter}
	}
}
