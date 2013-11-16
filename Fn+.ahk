#UseHook

; ===========================================================
; Vim like (https://github.com/verlane/Fn)
; ===========================================================
; modes = {:imode => nil, :nmode => [:vmode, :cmode]}
SetKeyDelay, -1 ;AutoHotkey 키 입력Delay를 최소화(기본값은 10)
global IS_FNKEY_FIXED := false ; Fn키 고정인가?
global IS_NMODE := false ; 노멀 모드인가?
global IS_VMODE := false ; 비주얼 모드인가?
global VIM_REPEAT := 0 ; 반복횟수
CapsLock::IS_NMODE := true
CapsLock Up::
	if (!IS_FNKEY_FIXED) {
		IS_NMODE := false
		IS_VMODE := false
	}
return
Space::
	if (IS_NMODE) {
		IS_FNKEY_FIXED := !IS_FNKEY_FIXED 
		if (!IS_FNKEY_FIXED) {
			ClearAllMode()
		}
	} else {
		Send {Space}
	}	
	ShowModeTooltip()	
return
Esc::SendEscKey()
+v::
	if (IS_NMODE) {
		Send {Home}+{Down}
	}
v::
	if (IS_NMODE) {
 		IS_VMODE := !IS_VMODE
 	} else {
 		Send % A_ThisHotkey
 	}
	ShowModeTooltip()
return
SC027::Send % (IS_NMODE ? "{AppsKey}" : ";") ;Semicolon
a::SendFnKey("", "", true, true)
+a::SendFnKey("{End}", "{End}", true, true)
b::SendFnKey("^{Left _x_}", "^+{Left _x_}")
d::SendFnKey("{Home}+{Down _x_}^x", "^x", true)
+d::SendFnKey("+{End}^x", "^x", true)
e::SendFnKey("{BS _x_}", "{BS _x_}", true)
f::SendFnKey("{PgDn _x_}", "+{PgDn _x_}")
+f::SendFnKey("{PgUp _x_}", "+{PgUp _x_}")
g::SendFnKey("^{Home}", "^+{Home}")
+g::SendFnKey("^{End}", "^+{End}")
h::SendFnKey("{Left _x_}", "+{Left _x_}")
i::SendFnKey("", "", true, true)
+I::SendFnKey("{Home}", "{Home}", true, true)
j::SendFnKey("{Down _x_}", "+{Down _x_}")
+j::SendFnKey("{End}{Del}", "{End}{Del}", true)
k::SendFnKey("{Up _x_}", "+{Up _x_}")
l::SendFnKey("{Right _x_}", "+{Right _x_}")
m::SendFnKey("{Home}", "+{Home}")
+6::SendFnKey("{Home}", "+{Home}")
,::SendFnKey("{End}", "+{End}")
+4::SendFnKey("{End}", "+{End}")
o::SendFnKey("{End}{Enter _x_}", "{End}{Enter _x_}", true, true)
+o::SendFnKey("{Home}{Enter _x_}{Up _x_}", "{Home}{Enter _x_}{Up _x_}", true, true)
p::SendFnKey("^v", "^v",true)
+p::SendFnKey("^v", "^v", true)
r::SendFnKey("{Del _x_}", "^x", true, true)
u::SendFnKey("^z", "^z")
+u::SendFnKey("^y", "^y")
w::SendFnKey("^{Right _x_}", "^+{Right _x_}")
x::SendFnKey("{Del _x_}", "^x", true)
+x::SendFnKey("{BS _x_}", "^x", true)
y::SendFnKey("{Home}+{Down _x_}^c{Up}", "^c", true)
~::
	if (IS_NMODE) {
		temp := ClipboardAll
		Clipboard =
		SendFnKey("+{Right _x_}^x", "^x", true)
		ClipWait 1
		if Clipboard is upper
			StringLower, outputVar, Clipboard
		else 
			StringUpper, outputVar, Clipboard
		Send % outputVar
		clipboard := temp
	} else {
		Send % A_ThisHotkey
	}
return
0::
1::
2::
3::
4::
5::
6::
7::
8::
9::
	SendNumberKey()
return

SendNumberKey() {
	if (IS_NMODE) {
		VIM_REPEAT := VIM_REPEAT * 10 + A_ThisHotkey
		ShowModeTooltip()
	} else {
		Send % A_ThisHotkey
	}
}

SendFnKey(nmodeTKey, vmodeTKey, clearVMode:=false, clearNMode:=false) {
	VIM_REPEAT := VIM_REPEAT < 1 ? 1 : (VIM_REPEAT > 100 ? 100 : VIM_REPEAT)
	nmodeTkey := RegExReplace(nmodeTkey, "_x_", VIM_REPEAT)
	vmodeTkey := RegExReplace(vmodeTkey, "_x_", VIM_REPEAT)
	Send % (IS_NMODE ? (IS_VMODE ? vmodeTKey : nmodeTKey) : A_ThisHotkey)
	if (clearVMode)  {
		IS_VMODE := false
	}
	if (IS_FNKEY_FIXED && clearNMode)  {
		IS_NMODE := false
	}
	VIM_REPEAT := 0
	ShowModeTooltip()
}
SendEscKey(sendCount:=1) {
	if (IS_FNKEY_FIXED) {
		if (IS_NMODE && !IS_VMODE) {
			Send {Esc %sendCount%}
		}
		IS_NMODE := true
		IS_VMODE := false
	} else {
		Send {Esc %sendCount%}
	}
	VIM_REPEAT := 0
	ShowModeTooltip()
}
ClearAllMode() {
	IS_FNKEY_FIXED := false
	IS_NMODE := false
	IS_VMODE := false
}
ShowModeTooltip() {
	WinGetPos, x, y, width, height, A
	if (IS_FNKEY_FIXED) {
		ToolTip % (IS_NMODE ? (IS_VMODE ? "V:" : "N:") : "I:") VIM_REPEAT, 0, height - 20
	} else {
		ToolTip
	}
}

#UseHook off
