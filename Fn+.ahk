﻿#SingleInstance force

; ===========================================================
; Vim like (https://github.com/verlane/Fn)
; ===========================================================

; icon
Menu, Tray, Icon, %A_ScriptDir%\Harwen-Simple-RUN.ico

#UseHook On
#Include  %A_ScriptDir%\IME.ahk

SetKeyDelay, -1 ;AutoHotkey 키 입력 Delay를 최소화(기본값은 10)

; _fnFixed_ : Fn키 고정
; _insert_ : 입력모드
; _normal_ : 노멀모드
; _visual_ : 비주얼모드
; _visualLine_ : 비주얼라인 상태
; _lineCopy_ : 행 복사 상태
; _rDown_ : 노멀모드에서 r상태
; _RDown_ : 노멀모드에서 R상태
; _fnDown_ : Fn키가 눌려진 상태

global gModes := Object(1, "_fnFixed_", 2, "_insert_", 3, "_normal_", 4, "_visual_", 5, "_visualLine_", 6, "_lineCopy_", 7, "_rDown_", 8, "_RDown_", 9, "_y_", 10, "_d_", 11, "_g_", 12, "_c_", 99, "_fnDown_")
global gVimMode := "" ; 현재 모드
global gRepeat := 0 ; 반복횟수
global gTabKey := false ; Tab키 입력인가?

global gShowToolTipCondition := "_fnFixed_|_fnDown_" ; 툴팁 표시 조건
global gNoClearToolTipCondition := "_fnFixed_" ; 툴팁 클리어 반대 조건
global gSendFnKeyCondition := "_normal_|_visual_" ; 스크립트 실행 조건

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
	gTabKey := false
}
ClearVimMode() {
	gVimMode := ""
	gRepeat := 0
}
IsVimMode(mode) {
	return RegExMatch(gVimMode, mode)
}
SendNumberKey() {
	if (!IsVimMode("_rDown_|_RDown") && IsVimMode("_normal_|_visual_")) {
		gRepeat := gRepeat * 10 + A_ThisHotkey
		gRepeat := gRepeat > 9999 ? 9999 : gRepeat
	} else {
		SendFnKey(A_ThisHotkey)
	}
}
SendFnKeyRDown(sendThisHotkey:=true) {
	if (IsVimMode("_rDown_|_RDown_")) {
		Send % "{Del}" (sendThisHotkey ? A_ThisHotkey : "")
		if (IsVimMode("_rDown_") && gRepeat > 0) {
			gRepeat := gRepeat - 1
		}
		if (gRepeat < 1) {
			SetVimMode("_normal_", "_rDown_")
		}
		return true
	}
	return false
}
SendFnKeyForce(sendKey="", appendMode:="", removeMode:="", loopCount:=1) {
	SendFnKey(sendKey, appendMode, removeMode, loopCount, true)
}
SendFnKey(sendKey="", appendMode:="", removeMode:="", loopCount:=1, forceFlag:=false) {
	if (!SendFnKeyRDown()) {
		loopCount := loopCount < 1 ? 1 : loopCount
		GetKeyState, ctrlStatus, Ctrl, P
		GetKeyState, altStatus, Alt, P
		Loop % loopCount
		{
			gRepeat := gRepeat < 1 ? 1 : gRepeat
			sendKey := RegExReplace(sendKey, "_n_", gRepeat)
			if (ctrlStatus == "D") {
				sendKey := "^" + sendKey
			}
			if (altStatus == "D") {
				sendKey := "!" + sendKey
			}
      if (GetKeyState("CapsLock", "T") = 1) {
				; TODO
      }
      if (WinActive("ahk_class Framework::CFrame")) { ;OneNote Up, Down bug fixed
        sendKey := RegExReplace(sendKey, "{Down", "^{Down")
        sendKey := RegExReplace(sendKey, "{Up", "^{Up")
      }
      Send % (forceFlag || IsVimMode(gSendFnKeyCondition) ? sendKey : A_ThisHotkey)
			SetVimMode(appendMode, removeMode)
			gRepeat := 0
		}
		SetVimMode("", "_y_d_g_c_")
	}
	gTabKey := false
}
SetImeOff() {
  if (IME_GET() = 1) {
    IME_GETConverting := IME_GETConverting()
    IME_GETConvMode := IME_GETConvMode()
    if (IME_GETConvMode = 0 || IME_GETConvMode = 1) {
      Send {VK15}
    } else if (IME_GETConverting = 0){ ; Japanese
      ; Send !{SC029} ; There is a bug on chrome. so, I'm using IME ESC function that is making ESC key to IME OFF.
    }
  }
}
SendEscKey(sendCount:=1) {
  if (!IsVimMode("_fnFixed_") || !IsVimMode("_insert_")) {
    SetImeOff()
  }
	if (IsVimMode("_fnFixed_")) {
		if (IsVimMode("_normal_")) {
			Send {Esc %sendCount%}
		}
		SetVimMode("_normal_")
	} else {
		Send {Esc %sendCount%}
	}
	SetVimMode("", "_visualLine_rDown_RDown_y_d_g_c_")
	gRepeat := 0
}
ShowToolTip:
	if (gVimMode != "") {
		WinGetPos, x, y, width, height, A
		ToolTip % gVimMode ":" gRepeat, 0, height
	}
return
ShowModeTooltip() {
	if (IsVimMode(gShowToolTipCondition)) {
		SetTimer, ShowToolTip, 50
	} else {
		SetTimer, ShowToolTip, Off
		ToolTip
	}
}

#Include %A_ScriptDir%\tmp\extensions.ahk

#If IsVimMode("_visual_") && IsVimMode("_visualLine_")
h::
l::
w::
b::SendFnKey("")

#If IsVimMode("_visual_")
b::SendFnKey("^+{Left _n_}")
c::SendFnKey("^x", "_insert_", "_lineCopy_")
+c::SendFnKey("^x", "_insert_", "_lineCopy_")
d::SendFnKey("^x", "_normal_", "_lineCopy_")
+d::SendFnKey("^x", "_normal_", "_lineCopy_")
f::SendFnKey("+{PgDn _n_}")
+f::SendFnKey("+{PgUp _n_}")
g::SendFnKey("^+{Home}")
+g::SendFnKey("^+{End}")
h::SendFnKey("+{Left _n_}")
j::SendFnKey("+{Down _n_}")
k::SendFnKey("+{Up _n_}")
l::SendFnKey("+{Right _n_}")
+6::SendFnKey("+{Home}")
+4::SendFnKey("+{End}")
w::SendFnKey("^+{Right _n_}")
e::SendFnKey("^+{Right _n_}+{Left}")
x::SendFnKey("^x", "_normal_", "_lineCopy_")
+x::SendFnKey("^x", "_normal_", "_lineCopy_")
y::SendFnKey("^c", "_normal_", "_lineCopy_")

#If IsVimMode("_normal_") && IsVimMode("_lineCopy_")
p::SendFnKey("{Down}{Home}^v{Up}", "", "", gRepeat)
+p::SendFnKey("{Home}^v", "", "", gRepeat)

#If IsVimMode("_normal_") && !IsVimMode("_rDown_|_RDown_")
r::SetVimMode("_insert_rDown_")
+r::SetVimMode("_insert_RDown_")

#If IsVimMode("_rDown_|_RDown_")
v::
+V::SendFnKey()
~!::
~#::
~+::
~?::
~{::
~}::
~y::
~d::
~g::
	SendFnKeyRDown(false)
return

#If IsVimMode("_normal_") && IsVimMode("_y_") && IsVimMode("_g_")
g::SendFnKey("{End}+{Home}^+{Home}^c", "_lineCopy_")

#If IsVimMode("_normal_") && IsVimMode("_y_")
y::SendFnKey("{Home}+{Down _n_}+{Home}^c{Up}", "_lineCopy_")
g::SetVimMode("_g_")
+g::SendFnKey("{Home}+{End}^+{End}^c", "_lineCopy_")
w::SendFnKey("^+{Right _n_}^c")
e::SendFnKey("^+{Right _n_}+{Left}^c")
b::SendFnKey("^+{Left _n_}^c")
h::SendFnKey("+{Left _n_}^c")
j::SendFnKey("{Home}+{Down _n_}+{Down _n_}+{Home}^c{Up}", "_lineCopy_")
k::SendFnKey("{Down}{Home}+{Up _n_}+{Up _n_}^c{Down}", "_lineCopy_")
l::SendFnKey("+{Right _n_}^c")
+4::SendFnKey("+{End}^c")
+6::SendFnKey("+{Home}^c")

#If IsVimMode("_normal_") && IsVimMode("_d_") && IsVimMode("_g_")
g::SendFnKey("{End}+{Home}^+{Home}^x", "_lineCopy_")

#If IsVimMode("_normal_") && IsVimMode("_d_")
d::SendFnKey("{Home}+{Down _n_}^x", "_lineCopy_")
g::SetVimMode("_g_")
+g::SendFnKey("{Home}+{End}^+{End}^x", "_lineCopy_")
w::SendFnKey("^+{Right _n_}^x")
e::SendFnKey("^+{Right _n_}+{Left}^x")
b::SendFnKey("^+{Left _n_}^x")
h::SendFnKey("+{Left _n_}^x")
j::SendFnKey("{Home}+{Down _n_}+{Down _n_}+{Home}^x", "_lineCopy_")
k::SendFnKey("{Down}{Home}+{Up _n_}+{Up _n_}^x", "_lineCopy_")
l::SendFnKey("+{Right _n_}^x")
+4::SendFnKey("+{End}^x")
+6::SendFnKey("+{Home}^x")

#If IsVimMode("_normal_") && IsVimMode("_c_") && IsVimMode("_g_")
g::SendFnKey("{End}^+{Home}^x", "_insert_lineCopy_")

#If IsVimMode("_normal_") && IsVimMode("_c_")
c::SendFnKey("{Home}+{Down _n_}+{Home}^x", "_insert_lineCopy_")
b::SendFnKey("^+{Left _n_}^x", "_insert_")
w::SendFnKey("^+{Right _n_}^x", "_insert_")
e::SendFnKey("^+{Right}+{Left}^x", "_insert_", "", gRepeat)
+g::SendFnKey("{Home}^+{End}^x", "_insert_lineCopy_")

#If IsVimMode("_normal_") && IsVimMode("_g_")
g::SendFnKey("^{Home}{Down _n_}{Up}")

#If IsVimMode("_normal_")
y::SetVimMode("_y_", "_g_c_")
d::SetVimMode("_d_", "_g_c_")
g::SetVimMode("_g_", "_y_d_")
c::SetVimMode("_c_", "_y_d_")
+y::SendFnKey("{Home}+{Down _n_}+{Home}^c{Up}", "_lineCopy_")

#If
Tab::
	SetVimMode("_normal_fnDown_")
	ShowModeTooltip()
	gTabKey := true
return
Tab Up::
	if (gTabKey) {
		Hotkey Tab, Off
		Hotkey Tab Up, Off
		Send {Tab}
		Sleep 10
		Hotkey Tab, On
		Hotkey Tab Up, On
	}
	if (IsVimMode(gNoClearToolTipCondition)) {
		removeModes := "_fnDown_"
		if (!IsVimMode("_fnFixed_")) { ; 탭업일 때 _normal_ 모드를 제거
			removeModes := "_fnDown_normal_"
		}
		SetVimMode("", removeModes)
	} else {
		ClearVimMode()
	}
	ShowModeTooltip()
	gTabKey := false
return
Enter::
  ; TODO deleting "false"
	if (false && IsVimMode("_fnDown_")) {
		if (IsVimMode("_fnFixed_")) {
			SetVimMode("", "_fnFixed_")
			ClearVimMode()
		} else {
			SetVimMode("_fnFixed_")
		}
		ShowModeTooltip()
	} else {
		Send {Enter}
	}
	gTabKey := false
return
^[::SendEscKey(2)
SC029::
Esc::
  KeyWait %A_ThisHotkey%, T0.3
  if (ErrorLevel) { ; Esc長押しにAlt+F4
		WinGetClass winClass, A
		if (winClass == "ConsoleWindowClass") { ; on cmd.exe
			Send ^c^c^cexit{Enter}
		} else {
			Send !{F4}
		}
  } else {
    SendEscKey()
  }
  KeyWait %A_ThisHotkey%
return
+v::
	if (IsVimMode("_normal_")) {
		SendFnKey("{Home}+{Down _n_}+{Home}", "_visualLine_")
	}
v::
	if (IsVimMode("_normal_")) {
 		SetVimMode("_visual_")
 	} else if (IsVimMode("_visual_")) {
		SetVimMode("_normal_", "_visualLine_")
 	} else {
 		Send % A_ThisHotkey
 	}
return
a::SendFnKey("", "_insert_")
+a::SendFnKey("{End}", "_insert_")
b::SendFnKey("^{Left _n_}")
+d::SendFnKey("+{End}^x")
f::SendFnKey("{PgDn _n_}")
+f::SendFnKey("{PgUp _n_}")
+g::
  if (gRepeat > 0) {
    gRepeat := gRepeat - 1
    SendFnKey("^{Home}" + (gRepeat > 0 ? "{Down _n_}" : ""))
  } else {
    SendFnKey("^{End}")
  }
return
h::SendFnKey("{Left _n_}")
i::SendFnKey("", "_insert_")
+I::SendFnKey("{Home}", "_insert_")
j::SendFnKey("{Down _n_}")
+j::SendFnKey("{End}{Del}{End}", "", "", gRepeat)
k::SendFnKey("{Up _n_}")
l::SendFnKey("{Right _n_}")
+6::SendFnKey("{Home}")
+4::SendFnKey("{End}")
o::SendFnKey("{End}{Enter _n_}", "_insert_")
+o::SendFnKey("{Home}{Enter _n_}{Up _n_}", "_insert_")
p::
+p::SendFnKey("^v", "", "", gRepeat)
s::SendFnKey("{Del}", "_insert_")
+s::SendFnKey("{End}+{Home}{Del}", "_insert_")
u::SendFnKey("^z")
+u::SendFnKey("^y")
e::SendFnKey("^{Right _n_}{Left}")
w::SendFnKey("^{Right _n_}")
x::SendFnKey("{Del _n_}")
+x::SendFnKey("{BS _n_}")
+y::SendFnKey("{Home}+{Down _n_}+{Home}^c{Up}")
+c::SendFnKey("+{End}^x", "_insert_")
c::
m::
,::
t::
+t::
d::
y::
g::
n::
+n::
q::
+q::
r::
+r::
z::
+z::
`::
@::
%::
&::
*::
(::
)::
-::
_::
=::
[::
]::
\::
|::
'::
"::
<::
.::
>::
`;::
/::
:::SendFnKey()
0::(gRepeat > 0) ? SendNumberKey() : (IsVimMode("_visual_") ? SendFnKey("+{Home}") : SendFnKey("{Home}"))
1::
2::
3::
4::
5::
6::
7::
8::
9::
  ; KeyWait %A_ThisHotkey%, T0.3
  ; if (ErrorLevel) {
    ; Send #%A_ThisHotkey%
  ; } else {
    SendNumberKey()
  ; }
return

^c::
^x::
	if (IsVimMode("_visual_")) {
		SetVimMode("_normal_", "_visualLine_lineCopy_")
	}
	Send % A_ThisHotkey
return

#UseHook Off

