#UseHook

; ===========================================================
; Vim like (https://github.com/verlane/Fn)
; ===========================================================
; modes = {:imode => nil, :nmode => [:vmode, :cmode]}
SetKeyDelay, -1 ;AutoHotkey 키 입력Delay를 최소화(기본값은 10)

global gVimMode := "" ; 현재 모드 [_fnFixed_] + [_insert_, _normal_, _visual_] + [_command_] + [_preLineCopy_] + [_lineCopy_]
global gRepeatCount := 0 ; 반복횟수

SetVimMode(vimMode:="", fnFixed:="", preLineCopy:="", lineCopy:="") {
	if (vimMode != "")
		gVimMode := AppendString(gVimMode, "_insert_|_normal_|_visual_", vimMode)
	if (fnFixed != "")
		gVimMode := AppendString(gVimMode, "_fnFixed_", (fnFixed ? "_fnFixed_" : ""))
	if (preLineCopy != "")
		gVimMode := AppendString(gVimMode, "_preLineCopy_", (preLineCopy ? "_preLineCopy_" : ""))
	if (lineCopy != "")
		gVimMode := AppendString(gVimMode, "_lineCopy_", (lineCopy ? "_lineCopy_" : ""))
}

AppendString(target, regex, string) {
	target := RegExReplace(target, regex, string)
	if (!RegExMatch(gVimMode, regex)) {
		target := target string
	}
	return target
}
	
ClearVimMode() {
	gVimMode := ""
	gRepeatCount := 0
}
SetFnKeyFixed() {
	SetVimMode("", true)
}	
ClearFnKeyFixed() {
	SetVimMode("", false)
}	
SetInsertMode() {
	SetVimMode("_insert_")
}	
SetNormalMode() {
	SetVimMode("_normal_")
}	
SetVisualMode() {
	SetVimMode("_visual_")
}	
IsFnKeyFixed() {
	return RegExMatch(gVimMode, "_fnFixed_")
}
IsInsertMode() {
	return RegExMatch(gVimMode, "_insert_")
}
IsNormalMode() {
	return RegExMatch(gVimMode, "_normal_")
}
IsVisualMode() {
	return RegExMatch(gVimMode, "_visual_")
}
IsPreLineCopy() {
	return RegExMatch(gVimMode, "_preLineCopy_")
}
IsLineCopy() {
	return RegExMatch(gVimMode, "_lineCopy_")
}
SendNumberKey() {
	if (IsNormalMode() || IsVisualMode()) {
		gRepeatCount := gRepeatCount * 10 + A_ThisHotkey
		gRepeatCount := gRepeatCount > 100 ? 100 : gRepeatCount
		ShowModeTooltip()
	} else {
		Send % A_ThisHotkey
	}
}
SendFnKey(sendKey, vimMode:="") {
	gRepeatCount := gRepeatCount < 1 ? 1 : gRepeatCount
	sendKey := RegExReplace(sendKey, "_n_", gRepeatCount)
	Send % (IsNormalMode() || IsVisualMode() ? sendKey : A_ThisHotkey)
	SetVimMode(vimMode)
	gRepeatCount := 0
	ShowModeTooltip()
}
SendEscKey(sendCount:=1) {
	if (IsFnKeyFixed()) {
		if (IsNormalMode() && !IsVisualMode()) {
			Send {Esc %sendCount%}
		}
		SetNormalMode()
	} else {
		Send {Esc %sendCount%}
	}
	gRepeatCount := 0
	ShowModeTooltip()
}
ShowModeTooltip() {
	WinGetPos, x, y, width, height, A
	if (true || IsFnKeyFixed()) {
		ToolTip % gVimMode ":" gRepeatCount, 0, height - 20
	} else {
		ToolTip
	}
}
ShowModeTooltip()

#If IsFnKeyFixed() && IsNormalMode()
r::SendFnKey("{Del _n_}", "_insert_")

#If IsVisualMode()
b::SendFnKey("^+{Left _n_}")
d::SendFnKey("^x", "_normal_")
+d::SendFnKey("^x","_normal_")
f::SendFnKey("+{PgDn _n_}")
+f::SendFnKey("+{PgUp _n_}")
g::SendFnKey("^+{Home}")
+g::SendFnKey("^+{End}")
h::SendFnKey("+{Left _n_}")
j::SendFnKey("+{Down _n_}")
k::SendFnKey("+{Up _n_}")
l::SendFnKey("+{Right _n_}")
m::SendFnKey("+{Home}")
+6::SendFnKey("+{Home}")
,::SendFnKey("+{End}")
+4::SendFnKey("+{End}")
w::SendFnKey("^+{Right _n_}")
x::SendFnKey("^x", "_normal_")
+x::SendFnKey("^x", "_normal_")
y::SendFnKey("^c", "_normal_")

#If
CapsLock::
	SetVimMode("_normal_")
	ShowModeTooltip()
return
CapsLock Up::
	if (!IsFnKeyFixed()) {
		ClearVimMode()
	}
	ShowModeTooltip()
return
Space::
	if (IsNormalMode()) {
		if (IsFnKeyFixed()) {
			ClearFnKeyFixed()
		} else {
			SetFnKeyFixed()
		}
		if (!IsFnKeyFixed()) {
			ClearVimMode()
		}
	} else {
		Send {Space}
	}	
	ShowModeTooltip()	
return
Esc::SendEscKey()
+v::
	if (IsNormalMode()) {
		SendFnKey("{Home}+{Down _n_}")
	}
v::
	if (IsNormalMode()) {
 		SetVisualMode()
 	} else if (IsVisualMode()) {
 		SetNormalMode()
 	} else {
 		Send % A_ThisHotkey
 	}
	ShowModeTooltip()
return
a::SendFnKey("", "_insert_")
+a::SendFnKey("{End}", "_insert_")
b::SendFnKey("^{Left _n_}")
d::SendFnKey("{Home}+{Down _n_}^x")
+d::SendFnKey("+{End}^x")
e::SendFnKey("{BS _n_}")
f::SendFnKey("{PgDn _n_}")
+f::SendFnKey("{PgUp _n_}")
g::SendFnKey("^{Home}")
+g::SendFnKey("^{End}")
h::SendFnKey("{Left _n_}")
i::SendFnKey("", "_insert_")
+I::SendFnKey("{Home}", "_insert_")
j::SendFnKey("{Down _n_}")
+j::SendFnKey("{End}{Del}")
k::SendFnKey("{Up _n_}")
l::SendFnKey("{Right _n_}")
m::SendFnKey("{Home}")
+6::SendFnKey("{Home}")
,::SendFnKey("{End}")
+4::SendFnKey("{End}")
o::SendFnKey("{End}{Enter _n_}", "_insert_")
+o::SendFnKey("{Home}{Enter _n_}{Up _n_}", "_insert_")
p::SendFnKey("^v")
+p::SendFnKey("^v")
r::SendFnKey("{Del _n_}")
u::SendFnKey("^z")
+u::SendFnKey("^y")
w::SendFnKey("^{Right _n_}")
x::SendFnKey("{Del _n_}")
+x::SendFnKey("{BS _n_}")
y::SendFnKey("{Home}+{Down _n_}^c{Up}")
~::
	if (IsNormalMode()) {
		temp := ClipboardAll
		Clipboard =
		SendFnKey("+{Right _n_}^x")
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

^c::
^x::
	if (IsVisualMode()) {
		SetNormalMode()	
		SetVimMode("", "", false, false)
	}
	Send % A_ThisHotkey
return



#UseHook off
