RunFFCommand(count, key, modifier)
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
	Else If RegExMatch(key, "i)^l$") && RegExMatch(modifier, "i)^plus$")
		Send ^+{PgDn %count%}
	Else If RegExMatch(key, "i)^h$") && RegExMatch(modifier, "i)^plus$")
		Send ^+{PgUp %count%}
	Else If RegExMatch(key, "i)^b$") && !RegExMatch(modifier, "i)^plus$")
		Send !{Left}
	Else If RegExMatch(key, "i)^f$") && RegExMatch(modifier, "i)^ctrl$")
	{
		Send ^f
		vi := 0
	}
	Else If RegExMatch(key, "i)^f$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send !{Right}
	Else If RegExMatch(key, "i)^u$")
		Send ^l
	Else If RegExMatch(key, "i)^x$") && !RegExMatch(modifier, "i)^plus$")
		Send ^x
	Else If RegExMatch(key, "i)^x$") && RegExMatch(modifier, "i)^plus$")
		Send ^{F4}
	Else If RegExMatch(key, "i)^r$")
		Send {F5}
	Else If RegExMatch(key, "i)^t$")
		Send ^t
	Else If RegExMatch(key, "i)^o$")
		Send {Enter}
	Else If RegExMatch(key, "i)^tab$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
		Send {Tab %count%}
	Else If RegExMatch(key, "i)^tab$") && RegExMatch(modifier, "i)^plus$")
		Send +{Tab %count%}
	Else If RegExMatch(key, "i)^a$") && RegExMatch(modifier, "i)^plus$")
		Send ^a
	Else If RegExMatch(key, "i)^fSlash$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		Send /
		vi := 0
		ChangeIcons()
	}
	Else If RegExMatch(key, "i)^dot$") && !RegExMatch(modifier, "i)^(ctrl|plus|alt)$")
	{
		Send .
		vi := 0
		ChangeIcons()
	}
	Else If RegExMatch(key, "i)^enter$")
		Send {Enter}
	Else If RegExMatch(key, "i)^q$") && RegExMatch(modifier, "i)^ctrl$")
	{
		ClickFunc(290, 640)
		Sleep, 3000
		ClickFunc(380, 240)
		Sleep, 3000
		Send {Tab 3}
		Sleep, 500
		Send {Enter}
	}
	Else If RegExMatch(key, "i)^s$") && RegExMatch(modifier, "i)^ctrl$")
		Send ^s
	Else If RegExMatch(key, "i)^s$") && RegExMatch(modifier, "i)^alt$")
	{
		Send ^s
		Sleep, 1000
		Send {Enter}
		Sleep, 1000
		Send ^{F4}
		Sleep, 400
		Send {Tab}
	}
	Else If RegExMatch(key, "i)^d$")
    {
        MouseGetPos, MouseX, MouseY
        ClickFunc(1839,65)
        Sleep, 500
        ClickFunc(MouseX,MouseY)
    }
}

; Firefox
#IfWinActive ahk_class MozillaWindowClass

$!r::
If pointNCLick != 0
{
	Send ^{F1}
	MouseMove 1014,122
	Send ^{F2}
}
Else
{
	MouseMove 1014,122
}

ClickFunc(214,122)
Sleep, 500
Send {Tab 2}
Sleep, 100
Send {Down}
Sleep, 100
Send {Tab}

vi:=0
Return

$^!h::
Send ^c
Sleep, 50
RunControlFocus("h")
Sleep, 700
Send @o
Sleep, 700
RunControlFocus("f")
Return

; function to select a textbox type in Umbraco
$^!t::
Sleep, 700
Send {Tab 4}
Sleep, 100
Send {Enter}
Sleep, 1500
Send {Tab 8}
Sleep, 100
Send {Enter}
Sleep, 1500
Send {Tab}
Sleep, 100
Send {Enter}
Sleep, 1500
Send +{Tab}
Sleep, 100
Send {Enter}
return

; extends previous function to grab text from vim then select a textbox type in Umbraco
; assumes macro f is HvEyj
$^!n::
InputBox, numOfLoops, "Number of iterations", "Enter a number"

Loop %numOfLoops%
{
	Sleep, 200
	Send {Enter}
	Sleep, 100
	RunControlFocus("h")
	Sleep, 200
	Send \qf
	Sleep, 500
	RunControlFocus("f")
	Sleep, 200
	Send ^v
	Sleep, 700
	Send {Tab 4}
	Sleep, 100
	Send {Enter}
	Sleep, 1500
	Send {Tab 8}
	Sleep, 100
	Send {Enter}
	Sleep, 1500
	Send {Tab}
	Sleep, 100
	Send {Enter}
	Sleep, 1500
	Send +{Tab}
	Sleep, 100
	Send {Enter}
	Sleep, 500
}
return

; used after prev function to fill in text to the properties we created on the content
$^!s::
; assumes macro r is
InputBox, numOfLoops, "Number of iterations", "Enter a number"

Loop %numOfLoops%
{
	Sleep, 100
	RunControlFocus("h")
	Sleep, 200
	Send \qr
	Sleep, 500
	RunControlFocus("f")
	Sleep, 200
	Send ^v
	Sleep, 100
	Send {Tab}
	Sleep, 100
}
return

; please kill this functionality; it keeps closing the browser window.
^w::
Return

^!b::
; InputBox, startDate, Start Date, Please enter the start date (YYYY-MM-DD):
; if ErrorLevel
;     return
; InputBox, endDate, End Date, Please enter the end date (YYYY-MM-DD):
; if ErrorLevel
;     return

startDate := "06/01/2025"
endDate := "09/01/2025"

; save folder path for later use
folderPath := "C:\Users\Rakk40\Desktop"

; locate all files in folder that start with "Chase" and end with "CSV" (case-insensitive)
Loop, %folderPath%\Chase*.csv
{
    chaseFile := A_LoopFileName
    ; do case-insensitive comparison using regex
    if (RegExMatch(chaseFile, "i)^Chase.*\.csv$"))
    {
        ; file matches criteria - delete it
        FileDelete, %folderPath%\%chaseFile%
    }
}

accountArray := ["2096","6389","","","0863","2902","7718"]
skipCounter := 0
for index, value in accountArray
{
	selectBoxIndex := index - 1

	if(StrLen(value) == 0)
	{
		skipCounter := skipCounter + 1 ;increment dropdown skips
	}
	else
    {
		Send {Tab}
		Sleep, 200
		Send {Tab}
		Sleep, 200
		Send {Tab}
		Sleep, 200
		Send {Enter}
		Sleep, 200
		if(selectBoxIndex != 0)
		{
			Send {Down}
			Sleep, 200
		}

		Loop, %skipCounter% ;loop over any skips that we found above
		{
			Sleep, 150
			Send {Down}
		}
		skipCounter := 0

		Send {Enter}
		Sleep, 200
		if(selectBoxIndex != 0)
		{
			Sleep, 4000
			Send {Tab 17}
		}

		Send {Tab}
		Sleep, 200
		Send {Tab}
		Sleep, 200
		Send {Enter}
		Sleep, 200

		Send {Up}
		Sleep, 200
		Send {Enter}
		Sleep, 200
		Send {Tab}
		Sleep, 200
		Send {Tab}
		Sleep, 200
		Send %startDate%
		Sleep, 200
		Send {Tab}
		Sleep, 200
		Send {Tab}
		Sleep, 200
		Send %endDate%
		Send {Tab}
		Sleep, 200
		Send {Tab}
		Sleep, 200
		Send {Tab}
		Sleep, 200
		Send {Enter}
		Sleep, 5000

		; Download has occurred
		Send {Esc}
		Sleep, 500
		Send {F5}
		Sleep, 15000

		; search file system until we find the file we're looking for
		; loop over the folder and find CSV file matching Chase{value}.*.csv
		; continue looping until we find the file or we reach 10 loops
		loopCount := 0
		foundFile := false
		chaseFile := ""  ; initialize variable to store found file name
		while (loopCount < 10 && !foundFile)
		{
			Loop, %folderPath%\Chase%value%*.csv
			{
				chaseFile := A_LoopFileName

				if (RegExMatch(chaseFile, "i)^Chase" . value . ".*\.csv$"))
				{
					; found matching file - can be used later
					foundFile := true
					break
				}
			}
			if (!foundFile)
			{
				loopCount++
				Sleep, 500
			}
		}

		; if we found a file, process it
		if (foundFile && chaseFile != "")
		{
			; store the full path for later use
			fullChaseFilePath := folderPath . "\" . chaseFile

			; read the file content and delete the first line
			FileRead, fileContent, %fullChaseFilePath%
			if (!ErrorLevel)
			{
				; split content by lines and remove first line
				StringSplit, lines, fileContent, `n
				newContent := ""
				Loop, %lines0%
				{
					if (A_Index > 1)  ; skip first line (index 1)
					{
						if (newContent != "")
							newContent .= "`n"
						newContent .= lines%A_Index%
					}
				}

				; write the modified content back to the file
				FileDelete, %fullChaseFilePath%
				FileAppend, %newContent%, %fullChaseFilePath%
			}

			; find a file that matches the same regex pattern in Budgeting/inputs
			; check if its last modified date is between startDate and endDate
			budgetingInputsPath := "C:\Users\Rakk40\Documents\Budgeting\inputs"
			Loop, %budgetingInputsPath%\Chase%value%*.csv
			{
				budgetingFile := A_LoopFileName
				if (RegExMatch(budgetingFile, "i)^Chase" . value . ".*\.csv$"))
				{
					; get the last modified date of this file
					FileGetTime, lastModified, %budgetingInputsPath%\%budgetingFile%, M
					if (!ErrorLevel)
					{
						; convert dates to comparable format (YYYYMMDD)
						; startDate is "06/01/2025" -> "20250601"
						; endDate is "08/01/2025" -> "20250801"
						startDateFormatted := 20250601
						endDateFormatted := 20250801

						; convert lastModified to number for comparison (take first 8 characters for YYYYMMDD)
						lastModifiedDate := SubStr(lastModified, 1, 8)
						lastModifiedNumber := lastModifiedDate + 0  ; convert to number

						; check if lastModified is between startDate and endDate
						if (lastModifiedNumber >= startDateFormatted && lastModifiedNumber <= endDateFormatted)
						{
							; splice the lines from the first file into the second line of the second file
							; read the content from the first file (fullChaseFilePath)
							FileRead, chaseFileContent, %fullChaseFilePath%
							if (!ErrorLevel)
							{
								; read the content from the second file (budgetingFile)
								FileRead, budgetingFileContent, %budgetingInputsPath%\%budgetingFile%
								if (!ErrorLevel)
								{
									; split both files into lines
									StringSplit, chaseLines, chaseFileContent, `n
									StringSplit, budgetingLines, budgetingFileContent, `n

									; create new content by inserting chase lines after the first line of budgeting file
									newBudgetingContent := ""

									; add first line from budgeting file
									newBudgetingContent := budgetingLines1

									; add all lines from chase file (starting from line 2 to skip header)
									Loop, %chaseLines0%
									{
										if (A_Index > 1)  ; skip first line (header)
										{
											newBudgetingContent .= "`n" . chaseLines%A_Index%
										}
									}

									; add remaining lines from budgeting file (starting from line 2)
									Loop, %budgetingLines0%
									{
										if (A_Index > 1)  ; skip first line (already added)
										{
											newBudgetingContent .= "`n" . budgetingLines%A_Index%
										}
									}

									; write the modified content back to the budgeting file
									FileDelete, %budgetingInputsPath%\%budgetingFile%
									FileAppend, %newBudgetingContent%, %budgetingInputsPath%\%budgetingFile%
								}
							}

							break
						}
					}
				}
			}
		}
	}
}
return
