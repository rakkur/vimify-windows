OpenFileInVim(app)
{
	clipboardSave := clipboard
	Sleep, 200
	; grab folder command in vs
	; File.CopyFullPath

	If RegExMatch(app, "i)^vs$")
		Send ^!k
	Else
		Send +!c

	Sleep, 200
	fileText := clipboard

	If !WinExist("ahk_class Vim")
		Run, C:\Program Files\Vim\vim91\gvim.exe "%clipboard%"
	Else If RegExMatch(app, "i)^cursor")
	{
		clipboard := fileText
		RunControlFocus("h")
		Sleep, 200
		Send {Esc}
		Sleep, 200
		Send {:}
		Sleep, 50
		Send e
		Sleep, 50
		Send {Space}
		Sleep, 50
		Send ^r
		Sleep, 50
		Send {+}
		Sleep, 50
		Send {Enter}
		Sleep, 50
	}
	Else
	{
		; get line number
		Send ^g
		Sleep, 300
		Send ^c
		Sleep, 50
		lineNo := clipboard
		Send {Esc}
		Sleep, 50

		; send file to vim
		clipboard := fileText
		RunControlFocus("h")
		Sleep, 200
		Send {Esc}
		Sleep, 200
		Send {:}
		Sleep, 50
		Send e
		Sleep, 50
		Send {Space}
		Sleep, 50
		Send ^r
		Sleep, 50
		Send {+}
		Sleep, 50
		Send {Enter}
		Sleep, 50

		; go to line no
		clipboard := lineNo
		Send {:}
		Sleep, 50
		Send ^r
		Sleep, 50
		Send {+}
		Sleep, 50
		Send {Enter}

	}

	; reset clipboard
	clipboard := clipboardSave
}

; *** Vim
#IfWinActive ahk_class Vim

Escape::
Send { Esc }
Return

F1::
if(toggleLanguage != 0)
	toggleLanguage := 1
else
	toggleLanguage := 0

Return

+F12::
RunControlFocus("x")
Return

+F10::
RunControlFocus("f")
Return

+F9::
RunControlFocus("r")
Return

$,::
if(!disableCommaTab)
    RunControlFocus(AppStack%appStackTotal%)
else
    Send {,}
Return

; function to send current file to cursor
$+F7::
Send !5
Sleep, 100
RunControlFocus("p")
Sleep, 200
Send !f
Sleep, 100
Send ^o
Sleep, 4000
Send ^v
Sleep, 50
Send {Enter}
Return

$+F8::
; need to make sure we control focus on the correct project
; this command transfers our @i register which always contains
; our current project name to the + register
Send {:}let {@}{+}{=}{@}i{Enter}
RunControlFocus("v", "", clipboard)
Sleep, 100
RunControlFocus("h")
Sleep, 50
Send !5
Sleep 50
RunControlFocus("v")
Send ^+t
Sleep, 300
Send ^v
Sleep, 2400
Send {Enter}
Sleep, 500
RunControlFocus("h")
Sleep, 1000
Send !4
Sleep, 100
RunControlFocus("v")
Sleep, 50
Send ^g
Sleep, 100
Send ^v
Sleep, 50
Send {Enter}
Sleep, 100
Send {F9}
Return

$!,::
Send {,}
Return
