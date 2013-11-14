#UseHook

; ===========================================================
; Vim like
; ===========================================================
global IS_FNMODE_FIXED := false ; Vim모드 고정인가?
global IS_FNMODE := false ; 명령어 모드인가?
global IS_VMODE := false ; 비주얼 모드인가?
CapsLock::IS_FNMODE := true
CapsLock Up::
	if (!IS_FNMODE_FIXED) {
		IS_FNMODE := false
		IS_VMODE := false
	}
return
Space::
	if (IS_FNMODE) {
		IS_FNMODE_FIXED := !IS_FNMODE_FIXED 
		if (!IS_FNMODE_FIXED) {
			ClearAllMode()
		}
	} else {
		Send {Space}
	}	
	ShowModeTooltip()	
return
Esc::SendEscKey()
v::
	if (IS_FNMODE) {
 		IS_VMODE := !IS_VMODE
 	} else {
 		Send v
 	}
	ShowModeTooltip()
return
a::SendFnKey("", "", "a", true, true)
+a::SendFnKey("{End}", "{End}", "A", true, true)
b::SendFnKey("+{PgUp}", "{PgUp}", "b")
d::SendFnKey("^x", "{End}+{Home}^x{Delete}", "d", true)
+d::SendFnKey("^x", "+{End}^x", "D", true)
e::SendFnKey("{BS}", "{BS}", "e", true)
f::SendFnKey("+{PgDn}", "{PgDn}", "f")
g::SendFnKey("^+{Home}", "^{Home}", "g")
+g::SendFnKey("^+{End}", "^{End}", "G")
h::SendFnKey("+{Left}", "{Left}", "h")
i::SendFnKey("", "", "i", true, true)
+I::SendFnKey("{Home}", "{Home}", "I", true, true)
j::SendFnKey("+{Down}", "{Down}", "j")
+j::SendFnKey("{End}{Del}", "{End}{Del}", "J", true)
k::SendFnKey("+{Up}", "{Up}", "k")
l::SendFnKey("+{Right}", "{Right}", "l")
m::SendFnKey("+{Home}", "{Home}", "m")
+6::SendFnKey("+{Home}", "{Home}", "+6")
,::SendFnKey("+{End}", "{End}", ",")
+4::SendFnKey("+{End}", "{End}", "+4")
o::SendFnKey("{End}{Enter}", "{End}{Enter}", "o", true, true)
+o::SendFnKey("{Home}{Enter}{Up}", "{Home}{Enter}{Up}", "O", true, true)
p::SendFnKey("^v", "^v", "p", true)
+p::SendFnKey("^v", "^v", "P", true)
r::SendFnKey("^x", "{Delete}", "r", true, true)
u::SendFnKey("^z", "^z", "u")
+u::SendFnKey("^y", "^y", "U")
w::SendFnKey("^+{Right}", "^{Right}", "w")
x::SendFnKey("^x", "{Delete}", "x", true)
+x::SendFnKey("^x", "{BS}", "X", true)
y::SendFnKey("^c", "{End}+{Home}^c", "y", true)
SendFnKey(vmodeTKey, vmodeFKey, fnmodeFKey, clearVMode:=false, clearFnMode:=false) {
	Send % (IS_FNMODE ? (IS_VMODE ? vmodeTKey : vmodeFKey) : fnmodeFKey)
	if (clearVMode)  {
		IS_VMODE := false
	}
	if (IS_FNMODE_FIXED && clearFnMode)  {
		IS_FNMODE := false
	}
	ShowModeTooltip()
}
SendEscKey(sendCount:=1) {
	if (IS_FNMODE_FIXED) {
		if (IS_FNMODE && !IS_VMODE) {
			Send {Esc %sendCount%}
		}
		IS_FNMODE := true
		IS_VMODE := false
	} else {
		Send {Esc %sendCount%}
	}
	ShowModeTooltip()
}
ClearAllMode() {
	IS_FNMODE_FIXED := false
	IS_FNMODE := false
	IS_VMODE := false
}
ShowModeTooltip() {
	WinGetPos, x, y, width, height, A
	if (IS_FNMODE_FIXED) {
		ToolTip % (IS_FNMODE ? (IS_VMODE ? "[V]" : "[Fn]") : "[In]"), 0, height - 20
	} else {
		ToolTip
	}
}

#UseHook off
