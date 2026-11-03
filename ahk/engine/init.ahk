; *** {{{ GUI elements, draw pics on screen

; init visual icon display gui commands
iconMode := tray_icon_edit . "_" . pointNCLick . ".bmp"
Loop 7
{
	Gui, %A_index%:Add, Picture, x0 y0 w16 h20 vPicture, %iconMode%
	Gui, %A_index%:+LastFound -Caption +AlwaysOnTop +ToolWindow -Border
	if(A_index = 1)
		Gui, %A_index%:Show, h20 w16 x0 y0
	else if (A_index = 2)
		Gui, %A_index%:Show, h20 w16 x-16 y85
	else if (A_index = 3)
		Gui, %A_index%:Show, h20 w16 x-1920 y85
	else if (A_index = 4)
		Gui, %A_index%:Show, h20 w16 x-1920 y1145
	else if (A_index = 5)
		Gui, %A_index%:Show, h20 w16 x-16 y1145
	else if (A_index = 6)
		Gui, %A_index%:Show, h20 w16 x0 y1145
	else if (A_index = 7)
		Gui, %A_index%:Show, h20 w16 x1904 y0
}


; Background picture is being added after the other GUI components
ChangeIcons()
{
	global
	iconMode := tray_icon_edit . "_" . pointNCLick . ".bmp"

	SPI_SETCURSORS := 0x57
	DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )

	Cursors = 32512,32513,32514,32515,32516,32640,32641,32642,32643,32644,32645,32646,32648,32649,32650,32651

	if(vi = 1 )
	{
		iconMode := tray_icon_normal . "_" . pointNCLick . ".bmp"
	}
	else
	{
		IDC_IBEAM := 32513
		CursorHandle := DllCall( "LoadCursor", Uint,0, Int,IDC_IBEAM )
		Loop, Parse, Cursors, `,
		{
			DllCall( "SetSystemCursor", Uint,CursorHandle, Int,A_Loopfield )
		}
	}

	; change pic
	Loop 7
	{
		GuiControl, %A_index%:, Picture, %iconMode%
	}


	; change tray icon
	Menu, TRAY, Icon, %iconMode%
}

ChangeIcons()

; }}}

; {{{ *** map keys
$1::
key := "1"
modifier := ""
GetUserCmd(key, modifier)
Return
$2::
key := "2"
modifier := ""
GetUserCmd(key, modifier)
Return
$3::
key := "3"
modifier := ""
GetUserCmd(key, modifier)
Return
$4::
key := "4"
modifier := ""
GetUserCmd(key, modifier)
Return
$5::
key := "5"
modifier := ""
GetUserCmd(key, modifier)
Return
$6::
key := "6"
modifier := ""
GetUserCmd(key, modifier)
Return
$7::
key := "7"
modifier := ""
GetUserCmd(key, modifier)
Return
$F6::
key := "F6"
modifier := ""
GetUserCmd(key, modifier)
Return
$+F6::
key := "F6"
modifier := ""
GetUserCmd(key, modifier)
Return
$8::
key := "8"
modifier := ""
GetUserCmd(key, modifier)
Return
$F7::
key := "F7"
modifier := ""
GetUserCmd(key, modifier)
Return
$+F7::
key := "F7"
modifier := ""
GetUserCmd(key, modifier)
Return
$9::
key := "9"
modifier := ""
GetUserCmd(key, modifier)
Return
$F8::
key := "F8"
modifier := ""
GetUserCmd(key, modifier)
Return
$+F8::
key := "F8"
modifier := ""
GetUserCmd(key, modifier)
Return
$0::
key := "0"
modifier := ""
GetUserCmd(key, modifier)
Return
$F9::
key := "F9"
modifier := ""
GetUserCmd(key, modifier)
Return
$+F9::
key := "F9"
modifier := ""
GetUserCmd(key, modifier)
Return
$F10::
key := "F10"
modifier := ""
GetUserCmd(key, modifier)
Return
$+F10::
key := "F10"
modifier := ""
GetUserCmd(key, modifier)
Return
$F11::
key := "F11"
modifier := ""
GetUserCmd(key, modifier)
Return
$+F11::
key := "F11"
modifier := ""
GetUserCmd(key, modifier)
Return
$F12::
key := "F12"
modifier := ""
GetUserCmd(key, modifier)
Return
$+F12::
key := "F12"
modifier := ""
GetUserCmd(key, modifier)
Return
$h::
key := "h"
modifier := ""
GetUserCmd(key, modifier)
Return
$+h::
key := "h"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$!h::
key := "h"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$^h::
key := "h"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$l::
key := "l"
modifier := ""
GetUserCmd(key, modifier)
Return
$+l::
key := "l"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$!l::
key := "l"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$^l::
key := "l"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$j::
key := "j"
modifier := ""
GetUserCmd(key, modifier)
Return
$^j::
key := "j"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$+j::
key := "j"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$!j::
key := "j"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$k::
key := "k"
modifier := ""
GetUserCmd(key, modifier)
Return
$^k::
key := "k"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$+k::
key := "k"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$!k::
key := "k"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$a::
key := "a"
modifier := ""
GetUserCmd(key, modifier)
Return
$+a::
key := "a"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$^a::
key := "a"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$i::
key := "i"
modifier := ""
GetUserCmd(key, modifier)
Return
$!i::
key := "i"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$o::
key := "o"
modifier := ""
GetUserCmd(key, modifier)
Return
$+o::
key := "o"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$^o::
key := "o"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$!o::
key := "o"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$g::
key := "g"
modifier := ""
GetUserCmd(key, modifier)
Return
$+g::
key := "g"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$u::
key := "u"
modifier := ""
GetUserCmd(key, modifier)
Return
$x::
key := "x"
modifier := ""
GetUserCmd(key, modifier)
Return
$+x::
key := "x"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$c::
key := "c"
modifier := ""
GetUserCmd(key, modifier)
Return
$!c::
key := "c"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$v::
key := "v"
modifier := ""
GetUserCmd(key, modifier)
Return
$!v::
key := "v"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$+v::
key := "v"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$^v::
key := "v"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$d::
key := "d"
modifier := ""
GetUserCmd(key, modifier)
Return
$+d::
key := "d"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$f::
key := "f"
modifier := ""
GetUserCmd(key, modifier)
Return
$^f::
key := "f"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$!f::
key := "f"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$+f::
key := "f"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$y::
key := "y"
modifier := ""
GetUserCmd(key, modifier)
Return
$p::
key := "p"
modifier := ""
GetUserCmd(key, modifier)
Return
$^p::
key := "p"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$r::
key := "r"
modifier := ""
GetUserCmd(key, modifier)
Return
$^r::
key := "r"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$+r::
key := "r"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$m::
key := "m"
modifier := ""
GetUserCmd(key, modifier)
Return
$!m::
key := "m"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$s::
key := "s"
modifier := ""
GetUserCmd(key, modifier)
Return
$^s::
key := "s"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$!s::
key := "s"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$+s::
key := "s"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$t::
key := "t"
modifier := ""
GetUserCmd(key, modifier)
Return
$^t::
key := "t"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$+t::
key := "t"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$q::
key := "q"
modifier := ""
GetUserCmd(key, modifier)
Return
$+q::
key := "q"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$!q::
key := "q"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$n::
key := "n"
modifier := ""
GetUserCmd(key, modifier)
Return
$b::
key := "b"
modifier := ""
GetUserCmd(key, modifier)
Return
$+b::
key := "b"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$!b::
key := "b"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$w::
key := "w"
modifier := ""
GetUserCmd(key, modifier)
Return
$!w::
key := "w"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$^w::
key := "w"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$z::
key := "z"
modifier := ""
GetUserCmd(key, modifier)
Return
$e::
key := "e"
modifier := ""
GetUserCmd(key, modifier)
Return
$;::
key := "semicolon"
modifier := ""
GetUserCmd(key, modifier)
Return
$!;::
key := "semicolon"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$/::
key := "fSlash"
modifier := ""
GetUserCmd(key, modifier)
Return
$\::
key := "bSlash"
modifier := ""
GetUserCmd(key, modifier)
Return
$,::
key := "comma"
modifier := ""
GetUserCmd(key, modifier)
Return
$+,::
key := "comma"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$!,::
key := "comma"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$F2::
key := "f2"
modifier := ""
GetUserCmd(key, modifier)
Return
$CapsLock::
$+CapsLock::
$!CapsLock::
$^CapsLock::
$+!CapsLock::
$+^CapsLock::
$!^CapsLock::
$Escape::
key := "esc"
modifier := ""
GetUserCmd(key, modifier)
Return
$Space::
key := "space"
modifier := ""
GetUserCmd(key, modifier)
Return
$!Space::
key := "space"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$^!=::
key := "equals"
modifier := "superalt"
GetUserCmd(key, modifier)
Return
$Tab::
key := "tab"
modifier := ""
GetUserCmd(key, modifier)
Return
$[::
key := "lBracket"
modifier := ""
GetUserCmd(key, modifier)
Return
$+[::
key := "lBracket"
modifier := "plus"
GetUserCmd(key, modifier)
Return
$+'::
key := "quote"
modifier := ""
GetUserCmd(key, modifier)
Return
; note: can't control +
$.::
key := "dot"
modifier := ""
GetUserCmd(key, modifier)
Return
$!.::
key := "dot"
modifier := "alt"
GetUserCmd(key, modifier)
Return
$^.::
key := "dot"
modifier := "ctrl"
GetUserCmd(key, modifier)
Return
$^!Right::
key := "right"
modifier := "superalt"
GetUserCmd(key, modifier)
Return
$^!Left::
key := "left"
modifier := "superalt"
GetUserCmd(key, modifier)
Return

$Enter::
key := "enter"
modifier := ""
GetUserCmd(key, modifier)
Return

$`::
key := "backtick"
modifier := ""
GetUserCmd(key, modifier)
Return

; }}}
