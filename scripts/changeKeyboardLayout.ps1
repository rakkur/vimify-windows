param(
	[Parameter(Mandatory=$true)]
	[string]$layout
)

if ($layout.ToLower() -eq "d")
{
    $1 = Get-WinUserLanguageList
    $1[0].InputMethodTips[0]="0409:00010409"
    Set-WinUserLanguageList -LanguageList $1 -Force
}
elseif ($layout.ToLower() -eq "q")
{
    $1 = Get-WinUserLanguageList
    $1[0].InputMethodTips[0]="0409:00000409"
    Set-WinUserLanguageList -LanguageList $1 -Force
}
