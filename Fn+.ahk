#UseHook

; ===========================================================
; Vim like (https://github.com/verlane/Fn)
; ===========================================================
; modes = {:imode => nil, :nmode => [:vmode, :cmode]}
SetKeyDelay, -1 ;AutoHotkey 키 입력Delay를 최소화(기본값은 10)

global gModes := Object(1, "_fnFixed_", 2, "_insert_", 3, "_normal_", 4, "_visual_", 5, "_preLineCopy_", 6, "_lineCopy_")
global gVimMode := "" ; 현재 모드
global gRepeatCount := 0 ; 반복횟수

SetVimMode(appendMode:="", removeMode:="") {
	if (appendMode) {
		if (RegExMatch(appendMode, "_insert_|_normal_|_visual_")) {
			gVimMode := RegExReplace(gVimMode, "_insert_|_normal_|_visual_", "")
		} 
		appendMode := appendMode gVimMode
		gVimMode := ""
		for index, element in gModes
		{
			if (RegExMatch(appendMode, element)) {
				gVimMode := RegExReplace(gVimMode, element, "")
				gVimMode := gVimMode element
			}
		}
	}
	if (removeMode) {
		for index, element in gModes
		{
			if (RegExMatch(removeMode, element))
				gVimMode := RegExReplace(gVimMode, element, "")
		}
	}
}

ClearVimMode() {
	gVimMode := ""
	gRepeatCount := 0
}
IsVimMode(mode) {
	return RegExMatch(gVimMode, mode)
}
SendNumberKey() {
	if (IsVimMode("_normal_") || IsVimMode("_visual_")) {
		gRepeatCount := gRepeatCount * 10 + A_ThisHotkey
		gRepeatCount := gRepeatCount > 100 ? 100 : gRepeatCount
		ShowModeTooltip()
	} else {
		Send % A_ThisHotkey
	}
}
SendFnKey(sendKey, appendMode:="", removeMode:="", loopCount:=1) {
	loopCount := loopCount < 1 ? 1 : loopCount
	Loop % loopCount
	{
		gRepeatCount := gRepeatCount < 1 ? 1 : gRepeatCount
		sendKey := RegExReplace(sendKey, "_n_", gRepeatCount)
		Send % (IsVimMode("_normal_") || IsVimMode("_visual_") ? sendKey : A_ThisHotkey)
		SetVimMode(appendMode, removeMode)
		gRepeatCount := 0
		ShowModeTooltip()
	}
}
SendFnKeyLoop(sendKey, appendMode:="", removeMode:="") {
	Loop gRepeatCount
	{
		SendFnKey(sendKey, appendMode, removeMode)
	}
}
SendEscKey(sendCount:=1) {
	if (IsVimMode("_fnFixed_")) {
		if (IsVimMode("_normal_")) {
			Send {Esc %sendCount%}
		}
		SetVimMode("_normal_")
	} else {
		Send {Esc %sendCount%}
	}
	SetVimMode("", "_preLineCopy_")
	gRepeatCount := 0
	ShowModeTooltip()
}

ShowToolTip:
	if (IsVimMode("_fnFixed_")) {
		WinGetPos, x, y, width, height, A
		ToolTip % gVimMode ":" gRepeatCount, 0, height - 20
	}
return

ShowModeTooltip() {
	if (IsVimMode("_fnFixed_")) {
		SetTimer, ShowToolTip, 50
	} else {
		SetTimer, ShowToolTip, Off
		ToolTip
	}
}

#If IsVimMode("_fnFixed_") && IsVimMode("_normal_")
r::SendFnKey("{Del _n_}", "_insert_")

#If IsVimMode("_visual"_) && IsVimMode("_preLineCopy_")
h::
l::
w::
b::SendFnKey("")
d::SendFnKey("^x", "_normal_lineCopy_", "_preLineCopy_")
e::SendFnKey("^x", "_normal_lineCopy_", "_preLineCopy_")
r::SendFnKey("^x", "_normal_lineCopy_", "_preLineCopy_")
x::SendFnKey("^x", "_normal_lineCopy_", "_preLineCopy_")
+x::SendFnKey("^x", "_normal_lineCopy_", "_preLineCopy_")
y::SendFnKey("^c", "_normal_lineCopy_", "_preLineCopy_")

#If IsVimMode("_visual_")
b::SendFnKey("^+{Left _n_}")
d::SendFnKey("^x", "_normal_", "_lineCopy_")
+d::SendFnKey("^x", "_normal_", "_lineCopy_")
e::SendFnKey("^x", "_normal_", "_lineCopy_")
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
r::SendFnKey("^x", "_normal_", "_lineCopy_")
w::SendFnKey("^+{Right _n_}")
x::SendFnKey("^x", "_normal_", "_lineCopy_")
+x::SendFnKey("^x", "_normal_", "_lineCopy_")
y::SendFnKey("^c", "_normal_", "_lineCopy_")

#If IsVimMode("_normal_") && IsVimMode("_lineCopy_")
p::SendFnKey("{Down}{Home}^v{Up}", "", "", gRepeatCount)
+p::SendFnKey("{Home}^v", "", "", gRepeatCount)

#If IsVimMode("_normal_")
d::SendFnKey("{Home}+{Down _n_}^x", "_lineCopy_")
y::SendFnKey("{Home}+{Down _n_}^c{Up}", "_lineCopy_")
+y::SendFnKey("{Home}+{Down _n_}^c{Up}", "_lineCopy_")

#If
CapsLock::
	SetVimMode("_normal_")
	ShowModeTooltip()
return
CapsLock Up::
	if (!IsVimMode("_fnFixed_")) {
		ClearVimMode()
	}
	ShowModeTooltip()
return
Space::
	if (IsVimMode("_normal_")) {
		if (IsVimMode("_fnFixed_")) {
			SetVimMode("", "_fnFixed_")
		} else {
			SetVimMode("_fnFixed_")
		}
		if (!IsVimMode("_fnFixed_")) {
			ClearVimMode()
		}
	} else {
		Send {Space}
	}	
	ShowModeTooltip()	
return
Esc::SendEscKey()
+v::
	if (IsVimMode("_normal_")) {
		SendFnKey("{Home}+{Down _n_}", "_preLineCopy_")
	}
v::
	if (IsVimMode("_normal_")) {
 		SetVimMode("_visual_")
 	} else if (IsVimMode("_visual_")) {
		SetVimMode("_normal_", "_preLineCopy_")
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
p::
+p::SendFnKey("^v", "", "", gRepeatCount)
r::SendFnKey("{Del _n_}")
u::SendFnKey("^z")
+u::SendFnKey("^y")
w::SendFnKey("^{Right _n_}")
x::SendFnKey("{Del _n_}")
+x::SendFnKey("{BS _n_}")
y::SendFnKey("{Home}+{Down _n_}^c{Up}")
+y::SendFnKey("{Home}+{Down _n_}^c{Up}")
~::
	if (IsVimMode("_normal_")) {
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
	if (IsVimMode("_visual_")) {
		SetVimMode("_normal_")	
		SetVimMode("", "_preLineCopy_lineCopy_")
	}
	Send % A_ThisHotkey
return



#UseHook off
