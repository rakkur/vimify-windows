; xplorer2 notes:  keyboard mappings need to be set up to work
; Alt-F2/F3 : move panel left/right
; Alt-F7: thumbnail ALT-F8: details toggle details/thumbnails.  also toggles UI to move tab by +h/+l

; pointNCLick notes:
; CTRL-F2: click
; CTRL-F1: cancel

SetTitleMatchMode RegEx

vi := 1
recordingMacro := 0
macroContainer := "f"
macroIndex := 0
ReturnClass := ""
appStackTotal := 0
running := 0
pointNCLick := 1
clipboardSave := ""
xplorer_filter := 1
sketchupPan := 0
tray_icon_normal := "ahk\icons\ahk"
tray_icon_edit := "ahk\icons\ahk_edit"
tmpCounter := 7
outlookMode := "mail"
currentMonitor := "Mirror"
disableCommaTab := 0

dynamicWindowsStack := { FF: [], CMD: [], VS: []}

GroupAdd, xplorerGrp, ahk_class ATL:ScrapFrame
GroupAdd, xplorerGrp, ahk_class ATL:ExplorerFrame

; initialize the dynamic windows
GetDynamicWindows("FF")
GetDynamicWindows("CMD")
GetDynamicWindows("VS")

; initialize our engine by mapping keys/creating gui elements
#Include %A_ScriptDir%\ahk\engine\init.ahk

; *** {{{ O/S functions
GetUserCmd(key, modifier)
{
	; get handle of current window
	global
	WinGet, SavedWinId, ID, A
	WinGetClass, comp, A
	WinGetTitle, winTitle, A

	if (RegExMatch(comp, "i)explorer") or RegExMatch(comp, "i)scrapframe"))
		ReturnClass := "fExp"
	else if RegExMatch(comp, "i)Vim")
		ReturnClass := "vim"
	else if RegExMatch(comp, "i)MozillaWindowClass")
		ReturnClass := "mozilla"
	else if RegExMatch(comp, "i)Chrome_WidgetWin_1")
    {
        ; need to look at the title of the program to determine which one it is
        if RegExMatch(winTitle, "i)- Azure Data Studio")
            ReturnClass := "tsql"
        else if RegExMatch(winTitle, "i)- Google Chrome")
            ReturnClass := "chrome"
        else if RegExMatch(winTitle, "i)automation")
            ReturnClass := "chrome"
        else if RegExMatch(winTitle, "i)Slack")
            ReturnClass := "slack"
        else if RegExMatch(winTitle, "i)Cursor")
            ReturnClass := "cursor"
        else if RegExMatch(winTitle, "i)Microsoft Teams")
            ReturnClass := "teams"
        else if RegExMatch(winTitle, "i)Visual Studio Code")
            ReturnClass := "vscode"
    }
	else if RegExMatch(comp, "i)ConfMultiTabContentWndClass")
		ReturnClass := "zoom"
	else if RegExMatch(comp, "i)IEFrame")
		ReturnClass := "ie"
	else if RegExMatch(comp, "i)Outlook Host")
		ReturnClass := "outlook"
	else if RegExMatch(comp, "i)Notepad")
		ReturnClass := "note"
	else if RegExMatch(comp, "i)C/SIDE Application")
		ReturnClass := "nav"
	else if RegExMatch(comp, "i)XLMAIN")
		ReturnClass := "xls"
	else if RegExMatch(comp, "i)SALFRAME")
		ReturnClass := "word"
	else if RegExMatch(comp, "i)wcl_manager1")
		ReturnClass := "jab"
	else if RegExMatch(comp, "i)HwndWrapper") || RegExMatch(comp, "i)VSDebugger")
		ReturnClass := "vs"
	else if RegExMatch(comp, "i)wxWindowClassNR")
		ReturnClass := "audacity"
	else if RegExMatch(comp, "i)AcrobatSDIWindow")
		ReturnClass := "acrobat"
	else if RegExMatch(comp, "i)G2WAttendeeViewer")
		ReturnClass := "joinme"
	else if RegExMatch(comp, "i)ConfMultiTabContentWndClass")
		ReturnClass := "joinme"
	else if (RegExMatch(comp, "i)ConsoleWindowClass") || RegExMatch(comp, "i)CASCADIA_HOSTING_WINDOW_CLASS"))
		ReturnClass := "cmd"
	else if RegExMatch(comp, "i)WindowsForms10.Window.8.app.0.[a-z0-9_]*")
		ReturnClass := "logex"
	else if RegExMatch(comp, "i)TscShellContainerClass")
		ReturnClass := "remote"
	else if RegExMatch(comp, "i)Qt5QWindowIcon")
		ReturnClass := "diff"
	else if RegExMatch(comp, "i)Afx:")
		ReturnClass := "sketch"
	else if RegExMatch(comp, "i)SALFRAME")
		ReturnClass := "word"
	else if RegExMatch(comp, "i)gdkWindowToplevel")
		ReturnClass := "gnucash"
	else if RegExMatch(comp, "i)SDL_app")
		ReturnClass := "scrcpy"
	else if RegExMatch(comp, "i)SnakeTail")
		ReturnClass := "snaketail"
	else
		ReturnClass := ""

	noSend := 0

    winTitle := ""
    WinGetActiveTitle, winTitle

    ; sketchup is special program
    If(RegExMatch(ReturnClass, "i)sketch"))
		RunSketchupCommand(1, key, modifier)
    Else If(RegExMatch(ReturnClass, "i)cmd") && RegExMatch(winTitle, "i)VIM$") || RegExMatch(ReturnClass, "i)cursor")) ; just send key if we are in a VIM console
    {
		ranCursor := 1
        If RegExMatch(key, "i)^lBracket$") && RegExMatch(modifier, "i)^plus$")
            Send {{}
        Else If RegExMatch(key, "i)^semicolon$") && RegExMatch(modifier, "i)^alt$")
            Send !{;}
        Else If RegExMatch(key, "i)^semicolon$")
            Send {;}
        Else If RegExMatch(key, "i)^dot$") && RegExMatch(modifier, "i)^alt$")
            Send !.
        Else If RegExMatch(key, "i)^dot$") && RegExMatch(modifier, "i)^ctrl$")
            Send ^.
        Else If RegExMatch(key, "i)^dot$")
            Send .
        Else If RegExMatch(key, "i)^backtick$")
            Send ``
        Else If RegExMatch(key, "i)^tab$")
            Send {Tab}
        Else If RegExMatch(key, "i)^fSlash$")
            Send /
        Else If RegExMatch(key, "i)^esc$")
            Send {Escape}
        Else If RegExMatch(key, "i)^f2$")
            Send {F2}
        Else If RegExMatch(key, "i)^lBracket$")
            Send [
        Else If RegExMatch(key, "i)^space$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
            Send {Space}
        Else If RegExMatch(key, "i)^space$") && RegExMatch(modifier, "i)^alt$")
            Send !{Space}
        Else If RegExMatch(key, "i)^enter$")
        {
            if toggleEditing = 1
            {
                toggleEditing := 0
                vi := 1
                ChangeIcons()
            }

            Send {Enter}
        }
        Else If RegExMatch(key, "i)^quote$")
            Send {"}
        Else If RegExMatch(key, "i)^F6$")
            Send {F6}
        Else If RegExMatch(key, "i)^F7$")
            Send {F7}
        Else If RegExMatch(key, "i)^F8$")
            Send {F8}
        Else If RegExMatch(key, "i)^F9$")
            Send {F9}
        Else If RegExMatch(key, "i)^F10$")
            Send {F10}
        Else If RegExMatch(ReturnClass, "i)cursor")
			ranCursor := RunCursorCommand(1, key, modifier)
		Else
			ranCursor := 0

		; need to continue if/else here if Cursor was not run
		If ranCursor = 0
		{
			If RegExMatch(key, "i)^comma$")
				Send {,}
			Else If RegExMatch(modifier, "i)^plus$")
				Send +%key%
			Else If RegExMatch(modifier, "i)^ctrl$")
				Send ^%key%
			Else If RegExMatch(modifier, "i)^alt$")
				Send !%key%
			Else If RegExMatch(key, "i)^bSlash$")
				Send \
			Else
				Send %key%
		}

        Return
    }
    Else
    {
        ; global actions (excluding vim of course!)
        If (!RegExMatch(ReturnClass, "i)vim")) && running != 1 && vi != 0
        {
            noSend := 1
            If !RegExMatch(modifier, "i)^(plus|alt|ctrl|superalt)$") ; no modifier group
            {
                If RegExMatch(key, "i)^g$")
                {
                    RunSwitchProgram_g(ReturnClass)
                    key := ""
                }
                Else If RegExMatch(key, "i)^comma$")
                {
                    RunControlFocus(AppStack%appStackTotal%)
                    key := ""
                }
                Else If RegExMatch(key, "i)^quote$")
                {
                    RunClipboardRegister()
                    key := ""
                }
                Else If RegExMatch(key, "i)^bSlash$")
                {
                    RunControlFocus("h")
                    key := ""
                }
                Else If RegExMatch(key, "i)^[ai]")
                {
                    vi := 0
                    ChangeIcons()
                }
                Else If RegExMatch(key, "i)^c")
                {
                    Send {Delete}
                    vi := 0
                    ChangeIcons()
                }
                Else If RegExMatch(key, "i)^enter") && !RegExMatch(ReturnClass, "i)vs")
                    Send {Enter}
                Else If RegExMatch(key, "i)^y$")
                    Send ^c
                Else If RegExMatch(key, "i)^p$")
                    Send ^v
                Else If RegExMatch(key, "i)^x$")
                    Send ^x
                Else If RegExMatch(key, "i)^semicolon$") && !RegExMatch(comp, "i)explorer") && !RegExMatch(comp, "i)scrapframe")
                    Send {PgDn}
                Else If RegExMatch(key, "i)^q$") && !RegExMatch(comp, "i)explorer") && !RegExMatch(comp, "i)scrapframe") && ReturnClass != "vs"
					Send {PgUp}
                Else If RegExMatch(key, "i)^u$")
                    Send ^z
                Else If RegExMatch(key, "i)^esc$")
                    Send {Escape}
                Else If RegExMatch(key, "i)^s$") && RegExMatch(modifier, "i)^ctrl$")
                {
                    Send ^c
                    Sleep, 50
                    RunControlFocus("h")
                    Sleep, 400
                    Send a
                    Sleep, 50
                    Send ^r
                    Sleep, 50
                    Send {+}
                    Sleep, 50
                    Send {Enter}
                    Sleep, 50
                    Send {Esc}
                    Sleep, 50
                    RunControlFocus(AppStack%appStackTotal%)
                    Sleep, 50
                }
                Else If RegExMatch(key, "i)^backtick$")
                {
                    If pointNCLick != 0
                    {
                        Send ^{F1}
                        pointNCLick := 0
                        ChangeIcons()
                    }
                    Else
                    {
                        Send ^{F2}
                        pointNCLick := 1
                        ChangeIcons()
                    }
                }
            }
            Else If RegExMatch(modifier, "i)^plus$") ; modifier groups
            {
                If RegExMatch(key, "i)^a$")
                    Send ^a
            }
            Else If RegExMatch(modifier, "i)^ctrl$")
            {
                If RegExMatch(key, "i)^a$")
                    Send ^a
                Else If RegExMatch(key, "i)^v$")
                    Send ^v
            }
            Else If RegExMatch(modifier, "i)^alt$")
            {
                If RegExMatch(key, "i)^semicolon$")
                    Send +{PgDn}
                Else If RegExMatch(key, "i)^q$")
                    Send +{PgUp}
                Else If RegExMatch(key, "i)^j$")
                    Send +{Down}
                Else If RegExMatch(key, "i)^k$")
                    Send +{Up}
                Else If RegExMatch(key, "i)^l$") && !RegExMatch(comp, "i)Outlook Host")
                    Send +{Right}
                Else If RegExMatch(key, "i)^h$") && !RegExMatch(comp, "i)Outlook Host")
                    Send +{Left}
            }
            Else If RegExMatch(modifier, "i)^superalt$")
            {
                ; multi key controls
                If RegExMatch(key, "i)^right$")
                {
                    Send, {LWin down}
                    Send +{Right}
                    Send, {LWin up}
                }
                Else If RegExMatch(key, "i)^left$")
                {
                    Send, {LWin down}
                    Send +{Left}
                    Send, {LWin up}
                }
            }
        }

        ; decide action based on handle
        If (!RegExMatch(ReturnClass, "i)vim") && running != 1 && vi != 0 && !RegExMatch(key, "i)^esc$"))
            GetUserInput(key, modifier, ReturnClass)
        Else If RegExMatch(key, "i)^esc$") && vi = 0
        {
            vi := 1
            ChangeIcons()
        }
        Else If noSend = 0
        {
            If RegExMatch(key, "i)^lBracket$") && RegExMatch(modifier, "i)^plus$")
                Send {{}
            Else If RegExMatch(key, "i)^semicolon$") && RegExMatch(modifier, "i)^alt$")
                Send !{;}
            Else If RegExMatch(key, "i)^semicolon$")
                Send {;}
            Else If RegExMatch(key, "i)^dot$") && RegExMatch(modifier, "i)^alt$")
                Send !.
            Else If RegExMatch(key, "i)^dot$") && RegExMatch(modifier, "i)^ctrl$")
                Send ^.
            Else If RegExMatch(key, "i)^dot$")
                Send .
            Else If RegExMatch(key, "i)^backtick$")
            {
                If(RegExMatch(ReturnClass, "i)vim"))
                    Send ``
                Else
                {
                    If pointNCLick != 0
                    {
                        Send ^{F1}
                        pointNCLick := 0
                         ChangeIcons()
                    }
                    Else
                    {
                        Send ^{F2}
                        pointNCLick := 1
                         ChangeIcons()
                    }
                }
            }
            Else If RegExMatch(key, "i)^tab$")
                Send {Tab}
            Else If RegExMatch(key, "i)^fSlash$") && RegExMatch(modifier, "i)^plus$")
                Send ?
            Else If RegExMatch(key, "i)^fSlash$")
                Send /
            Else If RegExMatch(key, "i)^esc$")
                Send {Escape}
            Else If RegExMatch(key, "i)^bSlash$")
                Send \
            Else If RegExMatch(key, "i)^f2$")
                Send {F2}
            Else If RegExMatch(key, "i)^lBracket$")
                Send [
			Else If RegExMatch(key, "i)^comma$") && RegExMatch(modifier, "i)^plus$")
				Send {<}
            Else If RegExMatch(key, "i)^comma$")
                Send {,}
            Else If RegExMatch(key, "i)^space$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
                Send {Space}
            Else If RegExMatch(key, "i)^space$") && RegExMatch(modifier, "i)^alt$")
                Send !{Space}
            Else If RegExMatch(key, "i)^enter$")
            {
                if toggleEditing = 1
                {
                    toggleEditing := 0
                    vi := 1
                    ChangeIcons()
                }

                Send {Enter}
            }
            Else If RegExMatch(key, "i)^quote$")
                Send {"}
            Else If RegExMatch(key, "i)^F6$")
                Send {F6}
            Else If RegExMatch(key, "i)^F7$")
                Send {F7}
            Else If RegExMatch(key, "i)^F8$")
                Send {F8}
            Else If RegExMatch(key, "i)^F9$")
                Send {F9}
            Else If RegExMatch(key, "i)^F10$")
                Send {F10}
            Else If RegExMatch(modifier, "i)^plus$")
                Send +%key%
            Else If RegExMatch(modifier, "i)^ctrl$")
                Send ^%key%
            Else If RegExMatch(modifier, "i)^alt$")
                Send !%key%
            Else
                Send %key%
        }
    }
}

RunClipboardRegister()
{
	global

	running := 1
	Input, userCmd, "BL2T3",{Escape}{Tab},y,p
	running := 0

	finalError := ErrorLevel

	; determine which section of the array to insert into {{{
	If RegExMatch(userCmd, "i)^a")
		alphaReg := 1
	Else If RegExMatch(userCmd, "i)^b")
		alphaReg := 2
	Else If RegExMatch(userCmd, "i)^c")
		alphaReg := 3
	Else If RegExMatch(userCmd, "i)^d")
		alphaReg := 4
	Else If RegExMatch(userCmd, "i)^e")
		alphaReg := 5
	Else If RegExMatch(userCmd, "i)^f")
		alphaReg := 6
	Else If RegExMatch(userCmd, "i)^g")
		alphaReg := 7
	Else If RegExMatch(userCmd, "i)^h")
		alphaReg := 8
	Else If RegExMatch(userCmd, "i)^i")
		alphaReg := 9
	Else If RegExMatch(userCmd, "i)^j")
		alphaReg := 10
	Else If RegExMatch(userCmd, "i)^k")
		alphaReg := 11
	Else If RegExMatch(userCmd, "i)^l")
		alphaReg := 12
	Else If RegExMatch(userCmd, "i)^m")
		alphaReg := 13
	Else If RegExMatch(userCmd, "i)^n")
		alphaReg := 14
	Else If RegExMatch(userCmd, "i)^o")
		alphaReg := 15
	Else If RegExMatch(userCmd, "i)^p")
		alphaReg := 16
	Else If RegExMatch(userCmd, "i)^q")
		alphaReg := 17
	Else If RegExMatch(userCmd, "i)^r")
		alphaReg := 18
	Else If RegExMatch(userCmd, "i)^s")
		alphaReg := 19
	Else If RegExMatch(userCmd, "i)^t")
		alphaReg := 20
	Else If RegExMatch(userCmd, "i)^u")
		alphaReg := 21
	Else If RegExMatch(userCmd, "i)^v")
		alphaReg := 22
	Else If RegExMatch(userCmd, "i)^w")
		alphaReg := 23
	Else If RegExMatch(userCmd, "i)^x")
		alphaReg := 24
	Else If RegExMatch(userCmd, "i)^y")
		alphaReg := 25
	Else If RegExMatch(userCmd, "i)^z")
		alphaReg := 26
	; }}}

	If RegExMatch(userCmd, "i)y$")
		GrabClipboard(alphaReg)
	Else If RegExMatch(userCmd, "i)p$")
		SendClipboard(alphaReg)
}

GetUserInput(key, modifier, ReturnClass)
{
	global

	; get number if possible
	If RegExMatch(key, "i)^[0-9]+$")
	{
		running := 1
		Input, userCmd, "BL2T3",{Escape}{Tab}{`,},l,h,j,k,q,g,i,t,n,s
		running := 0

		finalError := ErrorLevel

		; run some immediate number commands if necessary
		If RegExMatch(userCmd, "^q$")
		{
			userCmd := "tab"
			finalError := "Match"
		}
		Else If RegExMatch(userCmd, "^Q$")
		{
			; send alt-tab via q (can't do multiple shift-tab in input command above)
			userCmd := "tab"
			modifier := "plus"
			finalError := "Match"
		}
		Else If RegExMatch(finalError, "i)tab")
		{
			; send tabs
			finalError := "Match"
			userCmd := userCmd . "tab"
		}
		Else If RegExMatch(userCmd, "L") or RegExMatch(userCmd, "H") or RegExMatch(userCmd, "J") or RegExMatch(userCmd, "K") or RegExMatch(userCmd, "T")
		{
			; this function will get the contents of the next up to 10 cells in any arrow key or tab direction (excel, sql) and put them all in the clipboard. d,h,t,n,s,f,g,c,r,l
			finalError := "noAction"
			Loop %key%
			{
				If A_Index = 1
					GrabClipboard(4)
				Else If A_Index = 2
					GrabClipboard(8)
				Else If A_Index = 3
					GrabClipboard(20)
				Else If A_Index = 4
					GrabClipboard(14)
				Else If A_Index = 5
					GrabClipboard(19)
				Else If A_Index = 6
					GrabClipboard(6)
				Else If A_Index = 7
					GrabClipboard(7)
				Else If A_Index = 8
					GrabClipboard(3)
				Else If A_Index = 9
					GrabClipboard(18)
				Else If A_Index = 10
					GrabClipboard(12)

				If RegExMatch(userCmd, "L")
					Send {Right}
				Else If RegExMatch(userCmd, "H")
					Send {Left}
				Else If RegExMatch(userCmd, "J")
					Send {Up}
				Else If RegExMatch(userCmd, "K")
					Send {Down}
				Else If RegExMatch(userCmd, "T")
					Send {Tab}
			}

			key := key - 1
			; reset to original cell location
			Loop %key%
			{
				If RegExMatch(userCmd, "L")
					Send {Left}
				Else If RegExMatch(userCmd, "H")
					Send {Right}
				Else If RegExMatch(userCmd, "J")
					Send {Down}
				Else If RegExMatch(userCmd, "K")
					Send {Up}
				Else If RegExMatch(userCmd, "T")
					Send +{Tab}
			}
		}
		Else If RegExMatch(userCmd, "S")
		{
			finalError := "noAction"
			Loop %key%
			{
				If A_Index = 1
					SendClipboard(4)
				Else If A_Index = 2
					SendClipboard(8)
				Else If A_Index = 3
					SendClipboard(20)
				Else If A_Index = 4
					SendClipboard(14)
				Else If A_Index = 5
					SendClipboard(19)
				Else If A_Index = 6
					SendClipboard(6)
				Else If A_Index = 7
					SendClipboard(7)
				Else If A_Index = 8
					SendClipboard(3)
				Else If A_Index = 9
					SendClipboard(18)
				Else If A_Index = 10
					SendClipboard(12)

				If RegExMatch(userCmd, "S")
					Send {Tab}
			}

			key := key - 1
			; reset to original cell location
			Loop %key%
			{
				If RegExMatch(userCmd, "S")
					Send +{Tab}
			}
		}

		; got numbers, determine key/command
		If RegExMatch(finalError, "i)match") or RegExMatch(finalError, "i)max") or RegExMatch(finalError, "i)EndKey:,")
		{
			; if multiple numbers, build vars
			If RegExMatch(userCmd, "i)^[0-9]")
			{
				StringLeft, tmpCmd, userCmd, 1
				tmpCmd := (key * 10) + tmpCmd
				key := tmpCmd

				If RegExMatch(userCmd, "i)tab")
				{
					userCmd := "tab"
				}
				Else
				{
					StringRight, tmpCmd, userCmd, 1
					userCmd := tmpCmd
				}
			}

			; bracket is a special key; it will execute a program jump from the AppStack.
			; this is all based on the array and the number of values in it, so if you go from h->x->r,
			; 2[ will bring you back to h, while [ will bring you back to x
			if RegExMatch(finalError, "i)^EndKey:,$")
			{
				if(appStackTotal > key)
					tmpCount := appStackTotal - key
				else
					tmpCount := 1

				; make sure not to hit the same program we are currently on; if so, add one to the array counter
				regex := "i)^" . AppStack%tmpCount% . "$"
				if RegExMatch(thisProgram, regex)
					tmpCount := tmpCount + 1

				; finally, switch programs
				AdjustAppStack()
				RunControlFocus(AppStack%tmpCount%)
			}
		}
	}
	Else
	{
		userCmd := key
		key := 1
	}

	if RegExMatch(key, "i)^[jkhl]") && !RegExMatch(ReturnClass, "i)^fexp$")
	{
		If RegExMatch(key, "i)^j$")
			Send {Down %count%}
		Else If RegExMatch(key, "i)^k$")
			Send {Up %count%}
		Else If RegExMatch(key, "i)^l$")
			Send {Right %count%}
		Else If RegExMatch(key, "i)^h$")
			Send {Left %count%}

	}
	else if RegExMatch(ReturnClass, "i)^chrome$")
		RunChromeCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^slack$")
		RunSlackCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^mozilla$")
		RunFFCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^ie$")
		RunIECommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^fexp$")
		RunExpCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^outlook$")
		RunOutlookCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^tsql$")
		RunSqlCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^note$")
		RunNotepadCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^xls$")
		RunXlsCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^word$")
		RunWordCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^jab$")
		RunJabberCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^vs$")
		RunVSCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^audacity$")
		RunAudacityCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^visio$")
		RunVisioCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^acrobat")
		RunAcrobatCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^logex")
		RunLogexCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^nav")
		RunNavCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^diff")
		RunFileDiffCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^sketch")
		RunSketchupCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^teams")
		RunTeamsCommand(key, userCmd, modifier)
	else if RegExMatch(ReturnClass, "i)^zoom")
		RunZoomCommand(key, userCmd, modifier)
}

RunSwitchProgram_g(ReturnClass)
{
	global
	running := 1
	Input, userCmd, "BL1T3",{Escape},x,f,h,g,r,o,m,s,p,n,l,i,w,e,v,j,a,d,i,y,c,q,t,1,2,3,4,5,6
	running := 0

	If RegExMatch(ErrorLevel, "i)match")
	{
		If RegExMatch(userCmd, "i)^[0-9]") ; catch another input to figure out which app
		{
			running := 1
			Input, userCmd2, "BL1T3",{Escape},x,f,h,g,r,o,m,s,p,n,l,i,w,e,v,j,a,d,i,y,c,q,t
			running := 0

			RunControlFocus(userCmd2, userCmd)
		}

        RunControlFocus(userCmd)
	}
}

AdjustAppStack()
{
	global
	; get current program to add to stack
	WinGet, SavedWinId, ID, A
	WinGetClass, comp, A
    WinGetTitle, winTitle, A

	if (RegExMatch(comp, "i)explorer") or RegExMatch(comp, "i)scrapframe"))
		thisProgram := "x"
	else if RegExMatch(comp, "i)Vim")
		thisProgram := "h"
	else if RegExMatch(comp, "i)MozillaWindowClass")
		thisProgram := "f"
	else if RegExMatch(comp, "i)Chrome_")
    {
        ; need to look at the title of the program to determine which one it is
        if RegExMatch(winTitle, "i)- Google Chrome")
			thisProgram := "a"
        else if RegExMatch(winTitle, "i)Slack")
			thisProgram := "r"
        else if RegExMatch(winTitle, "i)- Azure Data Studio")
			thisProgram := "s"
        else if RegExMatch(winTitle, "i)Microsoft Teams")
			thisProgram := "t"
        else if RegExMatch(winTitle, "i)Cursor")
			thisProgram := "p"
        else if RegExMatch(winTitle, "i)Visual Studio Code")
			thisProgram := "p"
    }
	else if RegExMatch(comp, "i)IEFrame")
		thisProgram := "i"
	else if RegExMatch(comp, "i)Outlook Host")
		thisProgram := "o"
	else if RegExMatch(comp, "i)Notepad")
		thisProgram := "n"
	else if RegExMatch(comp, "i)C/SIDE Application")
		thisProgram := "n"
	else if RegExMatch(comp, "i)XLMAIN")
		thisProgram := "e"
	else if RegExMatch(comp, "i)SALFRAME")
		thisProgram := "w"
	else if RegExMatch(comp, "i)AcrobatSDIWindow")
		thisProgram := "p"
	else if RegExMatch(comp, "i)G2WAttendeeViewer")
		thisProgram := "y"
	else if RegExMatch(comp, "i)ConfMultiTabContentWndClass")
		thisProgram := "y"
	else if RegExMatch(comp, "i)wcl_manager1")
		thisProgram := "j"
	else if RegExMatch(comp, "i)wxWindowClassNR")
		thisProgram := "a"
	else if RegExMatch(comp, "i)HwndWrapper\[DefaultDomain;;.*") || RegExMatch(comp, "i)VSDebugger")
        thisProgram := "vs"
	else if (RegExMatch(comp, "i)ConsoleWindowClass") || RegExMatch(comp, "i)CASCADIA_HOSTING_WINDOW_CLASS"))
		thisProgram := "c"
	else if RegExMatch(comp, "i)WindowsForms10.Window.8.app.0.[a-z0-9_]*")
		thisProgram := "l"
	else if RegExMatch(comp, "i)SnakeTail")
		thisProgram := "l"
	else if RegExMatch(comp, "i)SALFRAME")
		thisProgram := "w"
	else if RegExMatch(comp, "i)gdkWindowToplevel")
		thisProgram := "a"
	else if RegExMatch(comp, "i)SDL_app")
		thisProgram := "a"
	else
		thisProgram := "x"

	remVal := 0
	; check if value is already in stack
	Loop %appStackTotal%
	{
		element := AppStack%A_Index%
		regex := "i)^" . thisProgram . "$"
		if(RegExMatch(AppStack%A_Index%, regex))
			remVal := A_Index
	}

	; if we found a duplicate, remove it from the stack
	If remVal != 0
	{
		counter := 0
		Loop %appStackTotal%
		{
			regex := "i)^" . remVal . "$"
			If(!RegExMatch(A_Index, remVal))
			{
				counter := counter + 1
				AppStack%counter% := AppStack%A_Index%
			}
		}

		appStackTotal := appStackTotal - 1
	}

	; finally, iterate stack
	appStackTotal := appStackTotal + 1
	AppStack%appStackTotal% := thisProgram
}


RunControlFocus(userCmd, userCmd2 = "", forceTitle = "")
{
	global
	AdjustAppStack()

	; check if the program we are switching to is the same one we are on currently, if so go back to first in the stack
	regex := "i)^" . AppStack%appStackTotal% . "$"
	if(RegExMatch(userCmd, regex) && appStackTotal > 1 && !RegExMatch(userCmd, "i)^f") && !RegExMatch(userCmd, "i)^v") && !RegExMatch(userCmd, "i)^c"))
	{
        tmpNum := 1
        userCmd := AppStack%tmpNum%
	}

	; now, switch program
	If RegExMatch(userCmd, "i)^x+") && WinExist("ahk_class ATL:ScrapFrame")
	{
		WinActivate
		ControlFocus, ATL:ScrapFrame
	}
	Else If RegExMatch(userCmd, "i)^x+") && WinExist("ahk_class ATL:ExplorerFrame")
	{
		WinActivate
		ControlFocus, ATL:ExplorerFrame
	}
	Else If RegExMatch(userCmd, "i)^x+")
	{
        Run, C:\Program Files\zabkat\xplorer2_ult\xplorer2_64.exe
	}
	Else If RegExMatch(userCmd, "i)^f+")
	{
        RunControlFocus_Dynamic(userCmd2, "FF")
	}
	Else If RegExMatch(userCmd, "i)^h+") && WinExist("ahk_class Vim")
	{
        Run, C:\Program Files\Vim\scripts\nircmd.exe win activate title "GVIM"
	}
	Else If RegExMatch(userCmd, "i)^h+")
	{
        Run, C:\Program Files\Vim\Vim91\gvim.exe
	}
	Else If (RegExMatch(userCmd, "i)^p+") || RegExMatch(userCmd, "i)^a+") || RegExMatch(userCmd, "i)^s+") || RegExMatch(userCmd, "i)^r+") || RegExMatch(userCmd, "i)^t+")) && WinExist("ahk_class Chrome_WidgetWin_1")
	{
        WinGet, windows, List, , , Program Manager
        Loop %windows%
        {
            id := windows%A_Index%
            WinGetClass, class, ahk_id %id%
            WinGetTitle, winTitle, ahk_id %id%

            If RegExMatch(class, "i)^Chrome_WidgetWin_1")
            {
                ; need to look at the title of the program to determine which one it is
                if RegExMatch(winTitle, "i)- Azure Data Studio") && RegExMatch(userCmd, "i)^s+")
                    WinActivate .*Azure Data Studio
                else if RegExMatch(winTitle, "i)- Google Chrome") && RegExMatch(userCmd, "i)^a+")
                    WinActivate .* - Google Chrome
                else if RegExMatch(winTitle, "i)Slack") && RegExMatch(userCmd, "i)^r+")
                    WinActivate Slack.*
                else if RegExMatch(winTitle, "i)Cursor") && RegExMatch(userCmd, "i)^p+")
                    WinActivate Cursor.*
                else if RegExMatch(winTitle, "i)Visual Studio Code") && RegExMatch(userCmd, "i)^p+")
                    WinActivate .*Visual Studio Code
                else if RegExMatch(winTitle, "i)Microsoft Teams") && RegExMatch(userCmd, "i)^t+")
                    WinActivate .*Microsoft Teams
            }
        }
	}
	Else If RegExMatch(userCmd, "i)^o+") && WinExist("ahk_class Outlook Host")
	{
		WinActivate
		ControlFocus, Outlook Host
	}
	Else If RegExMatch(userCmd, "i)^i+") && WinExist("ahk_class IEFrame")
	{
		WinActivate
		ControlFocus, IEFrame
	}
	Else If RegExMatch(userCmd, "i)^m+") && WinExist("ahk_class WMP Skin Host")
	{
		WinActivate
		ControlFocus, WMP Skin Host
	}
	Else If RegExMatch(userCmd, "i)^m+") && WinExist("ahk_class QWidget")
	{
		WinActivate
		ControlFocus, QWidget
	}
	Else If RegExMatch(userCmd, "i)^m+") && WinExist("ahk_class Qt5QWindowIcon")
	{
		WinActivate
		ControlFocus, Qt5QWindowIcon
	}
	Else If RegExMatch(userCmd, "i)^p+") && WinExist("ahk_class Photo_Lightweight_Viewer")
	{
		WinActivate
		ControlFocus, Photo_Lightweight_Viewer
	}
	Else If RegExMatch(userCmd, "i)^p+") && WinExist("ahk_class AcrobatSDIWindow")
	{
		WinActivate
		ControlFocus, AcrobatSDIWindow
	}
	Else If RegExMatch(userCmd, "i)^y+") && WinExist("ahk_class G2WAttendeeViewer") ;join me
	{
		WinActivate
		ControlFocus, G2WAttendeeViewer
	}
	Else If RegExMatch(userCmd, "i)^y+") && WinExist("ahk_class ConfMultiTabContentWndClass") ;zoom
	{
		WinActivate
		ControlFocus, ConfMultiTabContentWndClass
	}
	Else If RegExMatch(userCmd, "i)^c+") && (WinExist("ahk_class ConsoleWindowClass") || WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS"))
	{
        RunControlFocus_Dynamic(userCmd2, "CMD")
	}
	Else If RegExMatch(userCmd, "i)^y+") && WinExist("ahk_class TscShellContainerClass") ;remote desktop
	{
		WinActivate
		ControlFocus, TscShellContainerClass
	}
	Else If RegExMatch(userCmd, "i)^n+") && WinExist("ahk_class Notepad")
	{
		WinActivate
		ControlFocus, Notepad
	}
	Else If RegExMatch(userCmd, "i)^n+") && WinExist("ahk_class C/SIDE Application")
	{
		WinActivate
		ControlFocus, C/SIDE Application
	}
	Else If RegExMatch(userCmd, "i)^w+") && (WinExist("ahk_class SALFRAME") || WinExist("ahk_class SALFRAME"))
	{
		WinActivate
        If(WinExist("ahk_class SALFRAME"))
            ControlFocus, SALFRAME
        Else
            ControlFocus, SALFRAME
	}
	Else If RegExMatch(userCmd, "i)^e+") && WinExist("ahk_class XLMAIN")
	{
		WinActivate
		ControlFocus, XLMAIN
	}
	Else If RegExMatch(userCmd, "i)^j+") && WinExist("ahk_class wcl_manager1")
	{
		WinActivate
		ControlFocus, wcl_manager1
	}
	Else If RegExMatch(userCmd, "i)^a+") && WinExist("ahk_class SDL_app")
	{
		WinActivate
		ControlFocus, SDL_app
	}
	Else If RegExMatch(userCmd, "i)^a+") && WinExist("ahk_class wxWindowClassNR")
	{
		WinActivate
		ControlFocus, wxWindowClassNR
	}
	Else If RegExMatch(userCmd, "i)^a+") && WinExist("ahk_class AcrobatSDIWindow")
	{
		WinActivate
		ControlFocus, AcrobatSDIWindow
	}
	Else If RegExMatch(userCmd, "i)^a+") && WinExist("ahk_class gdkWindowToplevel")
	{
		WinActivate
		ControlFocus, gdkWindowToplevel
	}
	Else If RegExMatch(userCmd, "i)^l+")
	{
        WinGet, windows, List, , , Program Manager

        found := 0
        Loop %windows%
        {
            id := windows%A_Index%
            WinGetClass, class, ahk_id %id%

            If(RegExMatch(class, "i)WindowsForms10.Window.8.app.0.[a-z0-9_]*"))
            {
                SetTitleMatchMode 3
                WinGetTitle, winTitle, ahk_id %id%

                If(RegExMatch(winTitle, "i)^SnakeTail"))
                {
                    WinActivate %winTitle%
                    SetTitleMatchMode RegEx
                    found := 1
                }
            }
        }
	}

	Else If RegExMatch(userCmd, "i)^v+")
	{
        RunControlFocus_Dynamic(userCmd2, "VS", forceTitle)
	}
}

RunControlFocus_Dynamic(userCmd2, type, forceTitle = "")
{
	global

    counter := 1
    if(userCmd2 != "")
        counter := userCmd2

    if(forceTitle == "")
    {
        id := dynamicWindowsStack[type][counter]

        WinGet, pid_wg, PID, ahk_id %id%

        if StrLen(pid_wg) == 0
        {
            GetDynamicWindows(type)
            id := dynamicWindowsStack[type][1]
        }
    }
    else
    {
        WinGet, windows, List, , , Program Manager
        Loop %windows%
        {
            forcedId := windows%A_Index%
            WinGetClass, class, ahk_id %forcedId%
            WinGetTitle, title, ahk_id %forcedId%

            if (type == "VS" && RegExMatch(title, "i) - Microsoft Visual Studio") && RegExMatch(title, "i)" + forceTitle))
                id := forcedId
        }
    }

    WinActivate ahk_id %id%

    GetDynamicWindows(type)
}

GetDynamicWindows(type)
{
	global

	Stack := []

	WinGet, windows, List, , , Program Manager
	Loop %windows%
	{
		id := windows%A_Index%
		WinGetClass, class, ahk_id %id%
		WinGetTitle, title, ahk_id %id%

        if (type == "VS" && RegExMatch(title, "i) - Microsoft Visual Studio"))
            Stack.Push(id)
        if (type == "FF" && RegExMatch(title, "i)Firefox Developer Edition$"))
            Stack.Push(id)
        if (type == "CMD" && (RegExMatch(class, "i)ConsoleWindowClass") || RegExMatch(class, "i)CASCADIA_HOSTING_WINDOW_CLASS")))
            Stack.Push(id)
	}

    dynamicWindowsStack[type] := Stack
}

RecordMacro()
{
	global

	If recordingMacro = 0
	{
		running := 1
		Input, userCmd, "BL1T3",{Escape},a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
		running := 0

		finalError := ErrorLevel

		; determine which section of the array to insert into {{{
		If RegExMatch(userCmd, "i)^a")
			alphaReg := 1
		Else If RegExMatch(userCmd, "i)^b")
			alphaReg := 2
		Else If RegExMatch(userCmd, "i)^c")
			alphaReg := 3
		Else If RegExMatch(userCmd, "i)^d")
			alphaReg := 4
		Else If RegExMatch(userCmd, "i)^e")
			alphaReg := 5
		Else If RegExMatch(userCmd, "i)^f")
			alphaReg := 6
		Else If RegExMatch(userCmd, "i)^g")
			alphaReg := 7
		Else If RegExMatch(userCmd, "i)^h")
			alphaReg := 8
		Else If RegExMatch(userCmd, "i)^i")
			alphaReg := 9
		Else If RegExMatch(userCmd, "i)^j")
			alphaReg := 10
		Else If RegExMatch(userCmd, "i)^k")
			alphaReg := 11
		Else If RegExMatch(userCmd, "i)^l")
			alphaReg := 12
		Else If RegExMatch(userCmd, "i)^m")
			alphaReg := 13
		Else If RegExMatch(userCmd, "i)^n")
			alphaReg := 14
		Else If RegExMatch(userCmd, "i)^o")
			alphaReg := 15
		Else If RegExMatch(userCmd, "i)^p")
			alphaReg := 16
		Else If RegExMatch(userCmd, "i)^q")
			alphaReg := 17
		Else If RegExMatch(userCmd, "i)^r")
			alphaReg := 18
		Else If RegExMatch(userCmd, "i)^s")
			alphaReg := 19
		Else If RegExMatch(userCmd, "i)^t")
			alphaReg := 20
		Else If RegExMatch(userCmd, "i)^u")
			alphaReg := 21
		Else If RegExMatch(userCmd, "i)^v")
			alphaReg := 22
		Else If RegExMatch(userCmd, "i)^w")
			alphaReg := 23
		Else If RegExMatch(userCmd, "i)^x")
			alphaReg := 24
		Else If RegExMatch(userCmd, "i)^y")
			alphaReg := 25
		Else If RegExMatch(userCmd, "i)^z")
			alphaReg := 26
		; }}}

		; set up macro container vars
		macroContainer := alphaReg
		macroIndex := 0

		; signal to start recording
		recordingMacro := 1
	}
	else
		recordingMacro := 0
}

; }}}

; Dynamic includes - Auto-generated from ahk/apps directory using bat file
#Include %A_ScriptDir%\ahk\dynamic_includes.ahk
