RunNotepadCommand(count, key, modifier)
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
}
