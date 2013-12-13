FileGetTime extensionsFileTime, %A_ScriptDir%\tmp\extensions.ahk

isMakeExetensions := false

Loop %A_ScriptDir%\extensions\*.ahk
{
	FileGetTime outputTime, %A_LoopFileLongPath%
	if (outputTime > extensionsFileTime) {
		isMakeExetensions := true
		Break
	}
}

if (isMakeExetensions) {
	FileCreateDir %A_ScriptDir%\tmp
	FileDelete %A_ScriptDir%\tmp\extensions.ahk
	Loop %A_ScriptDir%\extensions\*.ahk
	{
		FileRead outputVar, %A_LoopFileLongPath%
		FileAppend %outputVar%`n, %A_ScriptDir%\tmp\extensions.ahk
	}
}

Run %A_ScriptDir%\Fn+.ahk
