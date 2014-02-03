#If WinActive("ahk_class Notepad") && IsVimMode("_normal_")
#::
	SendFnkey("^{Left}+^{Right}+{Left}^c^f")
	Send ^f
	Sleep 100
	Send ^v!u!f{Esc 2}
return
*::
	SendFnkey("^{Left}+^{Right}+{Left}^c^f")
	Send ^f
	Sleep 100
	Send ^v!d!f{Esc 2}
return
/::
	SendFnKey("^f")
	SetVimMode("_insert_")
return
n::SendFnKey("{F3}")
