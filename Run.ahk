Menu, Tray, Icon, %A_ScriptDir%\Harwen-Simple-RUN.ico

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

PostMessage(Receiver, Message) {
	oldTMM := A_TitleMatchMode, oldDHW := A_DetectHiddenWindows
	SetTitleMatchMode, 3
	DetectHiddenWindows, on
	PostMessage, 0x1001,%Message%,,, %Receiver% ahk_class AutoHotkeyGUI
	SetTitleMatchMode, %oldTMM%
	DetectHiddenWindows, %oldDHW%
}

PostMessage("Fn+.ahk", 1) ;exits Fn+.ahk script
Run %A_ScriptDir%\Fn+.ahk
