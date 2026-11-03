RunVSCommand(count, key, modifier)
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
	Else If RegExMatch(key, "i)^n$")
	{
		Sleep, 50
		Loop %count%
		{
			Send {F11}
			Sleep, 150
		}
	}
	Else If RegExMatch(key, "i)^f$")
	{
		Sleep, 50
		Loop %count%
		{
			Send {F10}
			Sleep, 150
		}
	}
	Else If RegExMatch(key, "i)^r$") && RegExMatch(modifier, "i)plus") ; run AT
	{
		Sleep, 50
		Send ^r
		Send t
	}
	Else If RegExMatch(key, "i)^r$") ; restart
	{
		Sleep, 50
		Send ^+{F5}
	}
	Else If RegExMatch(key, "i)^b$") && RegExMatch(modifier, "i)plus") ; just debug
	{
		Sleep, 50
		Send {F5}
	}
	Else If RegExMatch(key, "i)^b$") ; build and debug
	{
		Sleep, 50
		Send {F6}
		Sleep, 5000
		Send {F5}
	}
	Else If RegExMatch(key, "i)^m$") ; build and debug
	{
		Sleep, 50
		Send {F5}
	}
	Else If RegExMatch(key, "i)^e$") ; end
	{
		Sleep, 50
		Send +{F5}
	}
	Else If RegExMatch(key, "i)^x$") ; close
	{
		Sleep, 50
		Send ^{F4}
	}
	Else If RegExMatch(key, "i)^enter$")
	{
		Sleep, 50
	}
	Else If RegExMatch(key, "i)^t$") && RegExMatch(modifier, "i)plus") ; test explorer
	{
		Send ^e
		send t
	}
	Else If RegExMatch(key, "i)^t$") ; solution tree
	{
		Send ^!l
	}
	Else If RegExMatch(key, "i)^dot$") && RegExMatch(modifier, "i)ctrl") ; go to definition
	{
		Send {F12}
	}
	Else If RegExMatch(key, "i)^dot$") ; go to definition
	{
		Send ^{F12}
	}
	Else If RegExMatch(key, "i)^d$") && RegExMatch(modifier, "i)plus") ; run AT
	{
		Send ^e
		Send t
		Sleep, 50
		Send ^r
		Send ^t
	}
	Else If RegExMatch(key, "i)^d$") ; debug, next error
	{
		Send ^+{F12}
	}
	Else If RegExMatch(key, "i)^F12$") ; go to xplorer2
	{
		RunControlFocus("x")
	}
	Else If RegExMatch(key, "i)^F2$")
	{
		Send {F2}
		toggleEditing := 1
		vi := 0
	}
	Else If RegExMatch(key, "i)^fSlash$")
	{
		Send ^f
	}
	Else If RegExMatch(key, "i)^s$")
	{
		Send ^s
	}
	Else If RegExMatch(key, "i)^F8$")
	{
		Send ^!f
	}
	Else If RegExMatch(key, "i)^F9$")
	{
		Send {F9}
	}
	Else If RegExMatch(key, "i)^q$") ; get current debug value
	{
		Click
		Sleep, 50
		Send ^a
		Send ^c
		If RegExMatch(clipboard, "i)^""")
		{
			clipboard := SubStr(clipboard, 2, StrLen(clipboard) - 2)
		}

		Send {Esc}
	}
	Else If RegExMatch(key, "i)^o$") ; send current file path to vim
		OpenFileInVim("vs")
}
