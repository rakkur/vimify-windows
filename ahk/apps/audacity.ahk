RunAudacityCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)^f$") && !RegExMatch(modifier, "i)^(plus|alt|ctrl)$")
	{
		Send !f
		Send i
		Send a
	}
	Else If RegExMatch(key, "i)^f$") && RegExMatch(modifier, "i)ctrl")
	{
		Send !f
		Send i
		Send a
		Sleep, 1000
		Send C:\Users\Rakk40\Desktop\Radio\Take a trip - short.mp3
		Sleep, 200
		Send { Enter }
		Sleep, 1500

		Send !f
		Send i
		Send a
		Sleep, 1000
		Send C:\Users\Rakk40\Desktop\Radio\La ere gymnopedie.mp3
		Sleep, 200
		Send { Enter }
	}
	Else If RegExMatch(key, "i)^f$") && RegExMatch(modifier, "i)plus")
	{
		Send !f
		Send i
		Send a
		Sleep, 1000
		Send C:\Users\Rakk40\Desktop\Radio\Electro DnB A.mp3
		Sleep, 200
		Send { Enter }
		Sleep, 1500

		Send !f
		Send i
		Send a
		Sleep, 1000
		Send C:\Users\Rakk40\Desktop\Radio\La ere gymnopedie.mp3
		Sleep, 200
		Send { Enter }
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
	/*
	Else If RegExMatch(key, "i)^c$")
	{
		Send +{ End }
		Send { Delete }
		Send { End }
	}
	*/

}
