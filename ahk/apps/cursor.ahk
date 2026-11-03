RunCursorCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)^s$") && RegExMatch(modifier, "i)alt")
		Send ^s
	Else If RegExMatch(key, "i)^comma$") && RegExMatch(modifier, "i)plus")
	{
		RunControlFocus("v")
	}
	Else If RegExMatch(key, "i)^comma$") && RegExMatch(modifier, "i)alt")
		Send {,}
	Else If RegExMatch(key, "i)^comma$")
		RunControlFocus(AppStack%appStackTotal%)
	Else If RegExMatch(key, "i)^bSlash")
		RunControlFocus("h")
	Else If RegExMatch(key, "i)^l") && RegExMatch(modifier, "i)alt")
		Send g$
	Else If RegExMatch(key, "i)^o") && RegExMatch(modifier, "i)alt") ; get source control message AI generated
	{
		Send ^m
		Sleep, 100
		Send ^q
		Sleep, 300
		Send ^+g
		Sleep, 200
		Send {Esc}
		Sleep, 200
		Send {Tab}
		Sleep, 100
		Send {Enter}
		Sleep, 100
		Send +{Tab}
		Sleep, 100

		clipboard := ""
		AIMessage := ""
		Counter := 0
		While StrLen(AIMessage) <= 4
		{
			Sleep, 1000
			Send ^a
			Sleep, 50
			Send ^c
			Sleep, 50
			AIMessage := clipboard
		}

		Send ^m
		Sleep, 50
		Send ^q
		Sleep, 50

		OpenFileInVim("cursor")

		Send \ci
	}
	Else If RegExMatch(key, "i)^o") && RegExMatch(modifier, "i)ctrl")
		OpenFileInVim("cursor")
	Else If RegExMatch(key, "i)^h") && RegExMatch(modifier, "i)alt")
		Send {^}
	Else
		Return 0

	Return 1
}
