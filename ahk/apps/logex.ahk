RunLogexCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)j") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Down %count%}
	Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^plus$")
		Send {PgDn}
	Else If RegExMatch(key, "i)^k$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Up %count%}
	Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^plus$")
		Send {PgUp}
	Else If RegExMatch(key, "i)^l$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send ^{Tab %count%}
	Else If RegExMatch(key, "i)^h$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send ^+{Tab %count%}
	Else If RegExMatch(key, "i)^x$") && RegExMatch(modifier, "i)^plus$")
		Send ^{F4}
	Else If RegExMatch(key, "i)^a$") && RegExMatch(modifier, "i)^plus$")
		Send ^a
	Else If RegExMatch(key, "i)^d$")
	{
		Send ^{F4}
		Send ^o
		Sleep, 1000
		Send V
		Send {:}
		Send \LLGlobalErrorLogs\Error.log%A_MM%.%A_DD%.%A_YYYY%.log
		Send {Enter}
	}
	Else If RegExMatch(key, "i)^s$")
	{
		Send ^{F4}
		Send ^o
		Sleep, 1000
		Send X
		Send {:}
		Send \LLGlobalErrorLogs\Error.log%A_MM%.%A_DD%.%A_YYYY%.log
		Send {Enter}
	}
	Else If RegExMatch(key, "i)^w$")
	{
		Send ^{F4}
		Send ^o
		Sleep, 1000
		Send Z
		Send {:}
		Send \LLGlobalErrorLogs\Error.log%A_MM%.%A_DD%.%A_YYYY%.log
		Send {Enter}
	}
	Else If RegExMatch(key, "i)^fSlash$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		Send ^f
		vi := 0
		ChangeIcons()
	}
}
