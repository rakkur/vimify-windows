RunOutlookCommand(count, key, modifier)
{
	global
	If RegExMatch(outlookMode, "i)mail")
	{
		If RegExMatch(key, "i)j") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send {Down %count%}
		Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^plus$")
			Send {PgDn}
		Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^ctrl$")
			Send ^{Down}
		Else If RegExMatch(key, "i)^k$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send {Up %count%}
		Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^plus$")
			Send {PgUp}
		Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^ctrl$")
			Send ^{Up}
		Else If RegExMatch(key, "i)^l$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send {Right %count%}
		Else If RegExMatch(key, "i)^l$") && RegExMatch(modifier, "i)^plus$")
			Send {End}
		Else If RegExMatch(key, "i)^h$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send {Left %count%}
		Else If RegExMatch(key, "i)^h$") && RegExMatch(modifier, "i)^plus$")
			Send {Home}
		Else If RegExMatch(key, "i)^x$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send ^x
		Else If RegExMatch(key, "i)^o$")
			Send {Enter}
		Else If RegExMatch(key, "i)^d$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send {Delete}
		Else If RegExMatch(key, "i)^d$") && RegExMatch(modifier, "i)^(plus)$")
			Send +{Delete}
		Else If RegExMatch(key, "i)^e$")
			Send ^q
		Else If RegExMatch(key, "i)^m$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send ^q
		Else If RegExMatch(key, "i)^u$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send ^u
		Else If RegExMatch(key, "i)^n$")
			Send ^n
		Else If RegExMatch(key, "i)^s$") && RegExMatch(modifier, "i)^alt$")
			Send !s
		Else If RegExMatch(key, "i)^a$") && RegExMatch(modifier, "i)^plus$")
			Send ^a
		Else If RegExMatch(key, "i)^l$") && RegExMatch(modifier, "i)^alt$")
			Send ^+r
		Else If RegExMatch(key, "i)^r$") && RegExMatch(modifier, "i)^alt$")
			Send ^r
		Else If RegExMatch(key, "i)^w$") && RegExMatch(modifier, "i)^alt$")
            Send ^f
		Else If RegExMatch(key, "i)^f$")
			Send {Down}
		Else If RegExMatch(key, "i)^s$")
		{
			Send ^{2}
			outlookMode := "cal"
		}
		Else If RegExMatch(key, "i)^fSlash$")
		{
			Send ^e
			vi := 0
		}
	}
	Else
	{
		If RegExMatch(key, "i)^s$")
		{
			Send ^{1}
			outlookMode := "mail"
		}
		Else If RegExMatch(key, "i)^n$")
			Send ^n
		Else If RegExMatch(key, "i)j") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send {Down %count%}
		Else If RegExMatch(key, "i)j") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send {Down %count%}
		Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^plus$")
			Send {PgDn}
		Else If RegExMatch(key, "i)^j$") && RegExMatch(modifier, "i)^ctrl$")
			Send ^{Down}
		Else If RegExMatch(key, "i)^k$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send {Up %count%}
		Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^plus$")
			Send {PgUp}
		Else If RegExMatch(key, "i)^k$") && RegExMatch(modifier, "i)^ctrl$")
			Send ^{Up}
		Else If RegExMatch(key, "i)^l$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send {Right %count%}
		Else If RegExMatch(key, "i)^l$") && RegExMatch(modifier, "i)^plus$")
			Send {End}
		Else If RegExMatch(key, "i)^h$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
			Send {Left %count%}
		Else If RegExMatch(key, "i)^h$") && RegExMatch(modifier, "i)^plus$")
			Send {Home}

	}

    If RegExMatch(key, "i)^r$")
    {
        WinMinimize, A
        RunControlFocus("o")
    }
}

; *** Outlook
#IfWinActive ahk_class Outlook Host

; {{{ set up tab to expand text for emails
$Tab::
clipboardSave := clipboard
Send ^+{Left}
Send ^c
Sleep, 100
; check for key phrases, expand text
if RegExMatch(clipboard, "^thx$")
	Send Thanks -{Enter}~Eric
else if RegExMatch(clipboard, "^thxo$")
{
	Send {Backspace}
	Send !nas
	Send {Enter}
	Send {Up}
	Send {Up}
	Send {Delete}
	Send {Delete}
}
else if RegExMatch(clipboard, "^gthx$")
	Send Great, thanks
else if RegExMatch(clipboard, "^ps$")
	Send participant services
else if regexmatch(clipboard, "^htop$")
	send hot topics
else if RegExMatch(clipboard, "^ht$")
	Send Hey Tom -{Enter 2}
else if RegExMatch(clipboard, "^hc$")
	Send Hey Christian -{Enter 2}
else if RegExMatch(clipboard, "^hs$")
	Send Hey Sue -{Enter 2}
else if RegExMatch(clipboard, "^he$")
	Send Hey Eric -{Enter 2}
else if regexmatch(clipboard, "^perm$")
	send permission
else if regexmatch(clipboard, "^sp$")
	send stored proc
else if regexmatch(clipboard, "^db$")
	send database
else if regexmatch(clipboard, "^db$")
	send stored proc
else if regexmatch(clipboard, "^aw$")
	send anywhere
else if regexmatch(clipboard, "^ab$")
	send abstracts
else if regexmatch(clipboard, "^conv$")
	send conversion
else if regexmatch(clipboard, "^conf$")
	send configuration
else if regexmatch(clipboard, "^corr$")
	send corresponding
else if regexmatch(clipboard, "^prev$")
	send previously
else if regexmatch(clipboard, "^sol$")
	send solution
else if regexmatch(clipboard, "^auth$")
	send authorized
else if regexmatch(clipboard, "^ref$")
	send reference
else if regexmatch(clipboard, "^ef$")
	send entity framework
else if regexmatch(clipboard, "^taxy$")
	send taxonomies
else if regexmatch(clipboard, "^tax$")
	send taxonomy
else if regexmatch(clipboard, "^am$")
	send asset manager
else if regexmatch(clipboard, "^rep$")
	send repository
else if regexmatch(clipboard, "^ts$")
	send timestamp
else if regexmatch(clipboard, "^mani$")
	send manipulate
else if regexmatch(clipboard, "^mod$")
	send modification
else if regexmatch(clipboard, "^FF$")
	send FireFox
else if regexmatch(clipboard, "^IE$")
	send Internet Explorer
else if regexmatch(clipboard, "^SA$")
	send Safari
else if regexmatch(clipboard, "^jq$")
	send jQuery
else if regexmatch(clipboard, "^meth$")
	send methodology
else if regexmatch(clipboard, "^flex$")
	send flexibility
else if regexmatch(clipboard, "^mv$")
	send multiview
else if regexmatch(clipboard, "^cri$")
	send criteria
else if regexmatch(clipboard, "^lang$")
	send language
else
	Send {Tab}

clipboard := clipboardSave
Return
