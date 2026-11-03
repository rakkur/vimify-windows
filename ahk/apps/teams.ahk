RunTeamsCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)^m$")
        Send ^+m
	Else If RegExMatch(key, "i)^e$")
        Send ^+h
	Else If RegExMatch(key, "i)^s$")
    {
        Send ^+e
        Sleep, 1000
        Send +{Tab 7}
        Send {Enter}
    }

}
