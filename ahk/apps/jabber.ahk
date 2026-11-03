RunJabberCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)^h$")
		Send +{Tab %count%}
	Else If RegExMatch(key, "i)^l$")
		Send {Tab %count%}
	Else If RegExMatch(key, "i)^j$")
		Send ^{Tab}
	Else If RegExMatch(key, "i)^k$")
		Send ^+{Tab}
	Else If RegExMatch(key, "i)^x$") && RegExMatch(modifier, "i)plus")
		Send ^w
	Else If RegExMatch(key, "i)^p$") && RegExMatch(modifier, "i)ctrl")
	{
		; present
		Send +{Tab 10}
		Send {Enter}
	}
	Else If RegExMatch(key, "i)^a$") && RegExMatch(modifier, "i)ctrl")
	{
		; attach
		Send +{Tab 5}
		Send {Enter}
	}
}
