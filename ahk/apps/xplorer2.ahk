RunExpCommand(count, key, modifier)
{
	global

	If RegExMatch(key, "i)j") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Down %count%}
	Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^ctrl$")
		Send ^{Down}
	Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^plus$")
		Send {PgDn}
	Else If RegExMatch(key, "i)^k$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Up %count%}
	Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^ctrl$")
		Send ^{Up}
	Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^plus$")
		Send {PgUp}
	Else If RegExMatch(key, "i)^l$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		if toggleThumb = 1
		{
			if toggleThumbSwap = 1
				Send {Right %count%}
			else
			{
				Send !{F2 %count%}
				Sleep, 100
				Send ^!{F7}
			}
		}
		else
		{
			Send !{F2 %count%}
			Sleep, 100
			Send ^!{F7}
		}

	}
	Else If RegExMatch(key, "i)^l$") && RegExMatch(modifier, "i)^(plus)$")
	{
		if toggleThumb = 1
		{
			if toggleThumbSwap = 1
				Send !{F2 %count%}
		}
	}
	Else If RegExMatch(key, "i)^l$") && RegExMatch(modifier, "i)^(ctrl)$")
	{
		if toggleThumb = 1
		{
			if toggleThumbSwap = 1
				Send ^{Right}
		}
	}
	Else If RegExMatch(key, "i)^h$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		if toggleThumb = 1
		{
			if toggleThumbSwap = 1
				Send {Left %count%}
			else
			{
				Send !{F3 %count%}
				Sleep, 100
				Send ^!{F7}
			}
		}
		else
		{
			Send !{F3 %count%}
			Sleep, 100
			Send ^!{F7}
		}
	}
	Else If RegExMatch(key, "i)^h$") && RegExMatch(modifier, "i)^(plus)$")
	{
		if toggleThumb = 1
		{
			if toggleThumbSwap = 1
				Send !{F3 %count%}
		}
	}
	Else If RegExMatch(key, "i)^h$") && RegExMatch(modifier, "i)^(ctrl)$")
	{
		if toggleThumb = 1
		{
			if toggleThumbSwap = 1
				Send ^{Left}
		}
	}
	Else If RegExMatch(key, "i)^b$") && !RegExMatch(modifier, "i)^plus$")
		Send !{Left}
	Else If RegExMatch(key, "i)^b$") && RegExMatch(modifier, "i)^plus$")
		Send {Backspace}
	Else If RegExMatch(key, "i)^f$")
		Send !{Right}
	Else If RegExMatch(key, "i)^o$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Enter}
	Else If RegExMatch(key, "i)^o$") && RegExMatch(modifier, "i)^ctrl$")
		Send {Enter}
	Else If RegExMatch(key, "i)^o$") && RegExMatch(modifier, "i)^plus$")
	{
		; get and reset clipboard
		clipboardSave := clipboard
		Sleep, 50
		Send !c
		Sleep, 200
		clipboardSavePath := clipboard
		Sleep, 50
		clipboard := clipboardSave
		Sleep, 50
		AdjustAppStack()
		Sleep, 250

        If WinExist("ahk_class Vim")
            Run, C:\Program Files\Vim\vim91\gvim.exe --remote "%clipboardSavePath%"
        Else
            Run, C:\Program Files\Vim\vim91\gvim.exe "%clipboardSavePath%"
	}
	Else If RegExMatch(key, "i)^semicolon$")
	{
		Send {Tab}

		If toggleThumbSwap = 0
			toggleThumbSwap := 1
		Else
			toggleThumbSwap := 0
	}
	Else If RegExMatch(key, "i)^a$") && RegExMatch(modifier, "i)^plus$")
		Send ^a
	Else If RegExMatch(key, "i)^f$")
		Send !{Right}
	Else If RegExMatch(key, "i)^u$")
		Send +{Tab}
	Else If RegExMatch(key, "i)^x$")
		Send ^x
	Else If RegExMatch(key, "i)^d$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Delete}
    ; duplicate files
	Else If RegExMatch(key, "i)^d$") && RegExMatch(modifier, "i)^plus$")
    {
		; get and reset clipboard
		clipboardSave := clipboard
		Sleep, 50
		Send !c
		clipboardSavePath := clipboard
		Sleep, 50
		clipboard := clipboardSave
		Sleep, 200

        If RegExMatch(clipboardSavePath, "i)\\I([A-Za-z]+)Repository([_a-zA-Z]+)?.cs$", Match)
        {
            RegExMatch(clipboardSavePath, "i)Repository([_a-zA-Z]+)?.cs$", EndMatch)
            DuplicateFile(Match, "I", EndMatch)
        }
        Else If RegExMatch(clipboardSavePath, "i)\\([A-Za-z]+)Repository([_a-zA-Z]+)?.cs$", Match)
        {
            RegExMatch(clipboardSavePath, "i)Repository([_a-zA-Z]+)?.cs$", EndMatch)
            DuplicateFile(Match, "", EndMatch)
        }
        Else If RegExMatch(clipboardSavePath, "i)\\([A-Za-z]+)Controller([_a-zA-Z]+)?.cs$", Match)
        {
            RegExMatch(clipboardSavePath, "i)Controller([_a-zA-Z]+)?.cs$", EndMatch)
            DuplicateFile(Match, "", EndMatch)
        }
        Else If RegExMatch(clipboardSavePath, "i)\\I([A-Za-z]+)Query([_a-zA-Z]+)?.cs$", Match)
        {
            RegExMatch(clipboardSavePath, "i)Query([_a-zA-Z]+)?.cs$", EndMatch)
            DuplicateFile(Match, "I", EndMatch)
        }
        Else If RegExMatch(clipboardSavePath, "i)\\([A-Za-z]+)Query([_a-zA-Z]+)?.cs$", Match)
        {
            RegExMatch(clipboardSavePath, "i)Query([_a-zA-Z]+)?.cs$", EndMatch)
            DuplicateFile(Match, "", EndMatch)
        }
        Else If RegExMatch(clipboardSavePath, "i)\\([A-Za-z]+)Check([_a-zA-Z]+)?.cs$", Match)
        {
            RegExMatch(clipboardSavePath, "i)Check([_a-zA-Z]+)?.cs$", EndMatch)
            DuplicateFile(Match, "", EndMatch)
        }
        Else If RegExMatch(clipboardSavePath, "i)\\([A-Za-z]+)Profile([_a-zA-Z]+)?.cs$", Match)
        {
            RegExMatch(clipboardSavePath, "i)Profile([_a-zA-Z]+)?.cs$", EndMatch)
            DuplicateFile(Match, "", EndMatch)
        }
        Else If RegExMatch(clipboardSavePath, "i)\\([A-Za-z]+)Factory([_a-zA-Z]+)?.cs$", Match)
        {
            RegExMatch(clipboardSavePath, "i)Factory([_a-zA-Z]+)?.cs$", EndMatch)
            DuplicateFile(Match, "", EndMatch)
        }
        Else If RegExMatch(clipboardSavePath, "i)\\([A-Za-z]+)Test([_a-zA-Z]+)?.cs$", Match)
        {
            RegExMatch(clipboardSavePath, "i)Test([_a-zA-Z]+)?.cs$", EndMatch)
            DuplicateFile(Match, "", EndMatch)
        }
        Else If RegExMatch(clipboardSavePath, "i)\\([A-Za-z]+)_([a-zA-Z]+).cs$", Match)
        {
            RegExMatch(clipboardSavePath, "i)_([a-zA-Z]+)?.cs$", EndMatch)
            DuplicateFile(Match, "", EndMatch)
        }
        Else If RegExMatch(clipboardSavePath, "i)\\([A-Za-z]+).cs$", Match)
        {
            RegExMatch(clipboardSavePath, "i).cs$", EndMatch)
            DuplicateFile(Match, "", EndMatch)
        }
    }
	Else If RegExMatch(key, "i)^c$") && RegExMatch(modifier, "i)^alt$")
		Send !c
	Else If RegExMatch(key, "i)^tab$")
		Send {Tab}
	Else If RegExMatch(key, "i)^space$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Space}
	Else If RegExMatch(key, "i)^g$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Home}
	Else If RegExMatch(key, "i)^g$") && RegExMatch(modifier, "i)^plus$")
		Send {End}
	Else If RegExMatch(key, "i)^F12$")
		Send {F12}
	Else If RegExMatch(key, "i)^fSlash$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		Send +{Tab}
        Send ^c
        Send {Esc}
		Send ^f
		Sleep, 150
        Send !i
        Send ^v
		Send !t
		Send {Delete}
		Sleep, 100
		vi := 0
		ChangeIcons()
	}
	Else If RegExMatch(key, "i)^t$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		if toggleThumb = 1
		{
			toggleThumb := 0
			Send !{F8}
		}
		else
		{
			toggleThumb := 1
			toggleThumbSwap := 1
			Send !{F7}
		}
	}
	Else If RegExMatch(key, "i)^f2$")
	{
		Send {F2}
		toggleEditing := 1
		vi := 0
		ChangeIcons()
	}
	Else If RegExMatch(key, "i)^F6$")
		Send {F6}
	Else If RegExMatch(key, "i)^F7$")
	{
		Send {F7}
		toggleEditing := 1
		vi := 0
		ChangeIcons()
	}
	Else If RegExMatch(key, "i)^F8$")
	{
		Send {F8}
		toggleEditing := 1
		vi := 0
		ChangeIcons()
	}
	Else If RegExMatch(key, "i)^F9$")
		Send {F9}
	Else If RegExMatch(key, "i)^F10$")
		Send {F10}
	Else If RegExMatch(key, "i)^enter$")
		Send {Enter}
	Else If RegExMatch(key, "i)^s$") && RegExMatch(modifier, "i)^ctrl$")
		ChangeXplFilter("Curr", xplorer_filter)
	Else If RegExMatch(key, "i)^t$") && RegExMatch(modifier, "i)^ctrl$")
		ChangeXplFilter("Typescr", xplorer_filter)
	Else If RegExMatch(key, "i)^w$") && RegExMatch(modifier, "i)^ctrl$")
		ChangeXplFilter("HTML", xplorer_filter)
    ; auto-resize!  awesome!!
	Else If RegExMatch(key, "i)^r$") && RegExMatch(modifier, "i)^ctrl$")
        WinMove, ahk_class ATL:ExplorerFrame,, -10, 400, 1935, 650
	Else If RegExMatch(key, "i)^equals$") && RegExMatch(modifier, "i)^superalt$")
        Send, ^!{NumpadAdd}
}

DuplicateFile(Match, Prefix, EndMatch)
{
    Send {F10}
    Sleep, 200
    Send {Enter}
    Sleep, 200
    arrayPoint := 4
    tmpValue := registerArray%arrayPoint%
    filePath := SubStr(Match, 2)
    Send xcopy %filePath% %Prefix%%tmpValue%%EndMatch%
    Send {Enter}
    Sleep, 100
    Send f
    Sleep, 200
    Send exit
    Send {Enter}
    Sleep, 200
    Send {Esc}
}

ChangeXplFilter(filter, onOff)
{
	global

	fullFilter = i)^%filter%$

	Send !h
	Sleep, 250
	If RegExMatch(onOff, fullFilter)
	{
		Send !e
		Sleep, 500
		Send !f
		Sleep, 50
		Send !f
		xplorer_filter := 1
	}
	Else
	{
		Send !n
		Sleep, 100
		Send {Delete}
		Sleep, 100
		Send !p
		Sleep, 100
		Send %filter%
		Sleep, 200
		Send {Up}
		Sleep, 50
		Send {Enter}
		xplorer_filter := filter
	}
}


#IfWinActive ahk_class xplorerGrp
$^!t::
Sleep, 500
Send {Home}
Send {Down 2}
Send {Enter}
Sleep, 1000
Send {Down}
Send !c
Sleep, 100
RunControlFocus("r")
Sleep, 200
RunControlFocus("x")
Sleep, 200
RunControlFocus("r")
Sleep, 200
MouseMove 723, 315
Sleep, 1000
Send ^v
Sleep, 500
Send {Enter}
Sleep, 300
MouseMove 564, 394
Return
