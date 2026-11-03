; ----- Solution root (same idea as g:SetProjectRoot *.sln/*.slnx) + GVim tagging -----
CsNormalizeRoot(p)
{
	StringReplace, p, p, /, \, All
	StringLower, p, p
	While InStr(p, "\\")
		StringReplace, p, p, \\, \, All
	return RTrim(p, "\")
}

CsDirHasSolution(dir)
{
	d := RTrim(dir, "\") . "\"
	Loop, Files, %d%*.sln, F
		return true
	Loop, Files, %d%*.slnx, F
		return true
	return false
}

; Deepest directory along full path that contains a .sln or .slnx (last match wins, like _vimrc SetProjectRoot).
CsSolutionRootFromFile(fullPath)
{
	fp := fullPath
	StringReplace, fp, fp, ", , All
	targetFilePath := ""
	found := ""
	Loop, Parse, fp, \
	{
		if StrLen(targetFilePath) > 0
		{
			if CsDirHasSolution(targetFilePath)
				found := targetFilePath
		}
		targetFilePath := targetFilePath . A_LoopField . "\"
	}
	return found
}

; Temp script: title looks like "|path| -- filename" (see :help 'titlestring' for %f).
CsWriteGvimTitleScript(normRoot)
{
	body := StrReplace(normRoot, "\", "/")
	StringReplace, bodySafe, body, ', '', All
	lines := "let &titlestring = '|" . bodySafe . "| -- %f'`r`n"
	tmp := A_Temp . "\ahk_gvim_ws_" . A_TickCount . ".vim"
	FileDelete, %tmp%
	FileAppend, %lines%, %tmp%
	return tmp
}

CsShortPath(longPath)
{
	try
	{
		sh := ComObjCreate("Scripting.FileSystemObject")
		if sh.FileExists(longPath)
			return sh.GetFile(longPath).ShortPath
	}
	return longPath
}

CsScheduleDeleteFile(path, delayMs := 800)
{
	global CsPendingDelete
	CsPendingDelete := path
	SetTimer, CsDeleteTempTimer, %delayMs%
}

CsDeleteTempTimer:
	global CsPendingDelete
	FileDelete, %CsPendingDelete%
	SetTimer, CsDeleteTempTimer, Off
	return

CsExtractGvimRootFromTitle(t)
{
	; "|path| -- filename" (also accept legacy GVIMROOT|path|ENDMARK from older builds)
	if RegExMatch(t, "\|([^|]+)\|\s*--", sub)
		return CsNormalizeRoot(StrReplace(sub1, "/", "\"))
	if RegExMatch(t, "GVIMROOT\|(.+?)\|ENDMARK", sub)
		return CsNormalizeRoot(StrReplace(sub1, "/", "\"))
	return ""
}

; Stable short name for gvim --servername (must match per-solution coc_data_home in _vimrc).
CsGvimServerName(normRoot)
{
	StringLower, s, normRoot
	h := 0
	Loop, Parse, s
		h := Mod(h * 31 + Asc(A_LoopField), 2147483647)
	hh := Abs(h)
	hex := ""
	Loop 8
	{
		d := Mod(hh, 16)
		hh := Floor(hh / 16)
		hex := SubStr("0123456789abcdef", d + 1, 1) . hex
	}
	return "g" . hex
}

CsFindGvimWindowForRoot(normRoot)
{
	WinGet, list, List, ahk_class Vim
	Loop %list%
	{
		id := list%A_Index%
		WinGetTitle, t, ahk_id %id%
		tr := CsExtractGvimRootFromTitle(t)
		if (tr != "" && tr = normRoot)
			return id
	}
	return 0
}

CsLaunchGvimForFile(fullPath, normRoot, lineNo := "")
{
	SplitPath, fullPath, fn, dir
	tmp := CsWriteGvimTitleScript(normRoot)
	tmpSrc := CsShortPath(tmp)
	cmdBody := "source " . tmpSrc
	srv := CsGvimServerName(normRoot)
	q := Chr(34)
	vimExe := "C:\Program Files\Vim\Vim92\gvim.exe"
	if lineNo =
		runLine := q . vimExe . q . " --servername " . srv . " --cmd " . q . cmdBody . q . " " . q . fullPath . q
	else
		runLine := q . vimExe . q . " --servername " . srv . " --cmd " . q . cmdBody . q . " +" . lineNo . " " . q . fullPath . q
	Run, %runLine%, %dir%
	CsScheduleDeleteFile(tmp)
}

; New GVim rooted at a folder (per solution). Global: Ctrl+Alt+Shift+G (defined below after #If reset).
RunNewGvimForSolution()
{
	FileSelectFolder, folder, , 3, Select solution or repo root for new GVim
	if ErrorLevel
		return
	if folder =
		return
	norm := CsNormalizeRoot(folder)
	tmp := CsWriteGvimTitleScript(norm)
	tmpSrc := CsShortPath(tmp)
	cmdBody := "source " . tmpSrc
	srv := CsGvimServerName(norm)
	q := Chr(34)
	vimExe := "C:\Program Files\Vim\Vim92\gvim.exe"
	runLine := q . vimExe . q . " --servername " . srv . " --cmd " . q . cmdBody . q
	Run, %runLine%, %folder%
	CsScheduleDeleteFile(tmp)
}

OpenFileInVim(app)
{
	clipboardSave := clipboard
	Sleep, 200
	; grab folder command in vs
	; File.CopyFullPath

	If RegExMatch(app, "i)^vs$")
		Send ^!k
	Else If RegExMatch(app, "i)^xplorer")
		Send !c
	Else
		Send +!c

	Sleep, 200
	fileText := clipboard

	slnRoot := CsSolutionRootFromFile(fileText)
	normRoot := CsNormalizeRoot(slnRoot)
	if (normRoot = "")
	{
		SplitPath, fileText, fnOnly, dirOnly
		normRoot := CsNormalizeRoot(dirOnly)
	}

	hwnd := CsFindGvimWindowForRoot(normRoot)

	If RegExMatch(app, "i)^cursor")
	{
		if !hwnd
		{
			CsLaunchGvimForFile(fileText, normRoot, "")
			clipboard := clipboardSave
			return
		}
		WinActivate ahk_id %hwnd%
		GvimRememberHwnd(hwnd)
		Sleep, 200
		clipboard := fileText
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
		; VS still focused — capture line number before switching to GVim
		Send ^g
		Sleep, 300
		Send ^c
		Sleep, 50
		lineNo := RegExReplace(clipboard, "[`r`n `t]", "")
		Send {Esc}
		Sleep, 50

		if !hwnd
		{
			if lineNo is not integer
				CsLaunchGvimForFile(fileText, normRoot, "")
			else
				CsLaunchGvimForFile(fileText, normRoot, lineNo)
			clipboard := clipboardSave
			return
		}

		WinActivate ahk_id %hwnd%
		GvimRememberHwnd(hwnd)
		Sleep, 200

		clipboard := fileText
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

; Multi-GVim: Ctrl+Alt+[ ] / 1..9 are defined globally at end of hotKeys.ahk (after includes).

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

#If

; Open a new GVim instance with cwd + titlestring set to the selected folder (from anywhere)
^!+g::
RunNewGvimForSolution()
Return
