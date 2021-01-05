Menu, Tray, Icon, %A_ScriptDir%\Harwen-Simple-RUN.ico

FileCreateDir %A_ScriptDir%\tmp
FileDelete %A_ScriptDir%\tmp\extensions.ahk
Loop %A_ScriptDir%\extensions\*.ahk
{
  FileRead outputVar, %A_LoopFileLongPath%
  FileAppend %outputVar%`n, %A_ScriptDir%\tmp\extensions.ahk
}

Run %A_ScriptDir%\Fn+.ahk
