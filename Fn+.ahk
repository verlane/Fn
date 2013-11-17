#UseHook

; ===========================================================
; Vim like (https://github.com/verlane/Fn)
; ===========================================================
; modes = {:imode => nil, :nmode => [:vmode, :cmode]}
SetKeyDelay, -1 ;AutoHotkey 키 입력Delay를 최소화(기본값은 10)
global IS_FNKEY_FIXED := false ; Fn키 고정인가?
global IS_NMODE := false ; 노멀 모드인가?
global IS_VMODE := false ; 비주얼 모드인가?
global IS_LINE_SUBMODE := false ; 라인 모드인가?

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
	KeyWait, y, T3.5
	if (IS_NMODE) {
		SendFnKey("_nlinemodeOn_{Home}+{Down _n_}", "_=nmodeTKey_", "")
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
a::SendFnKey("", "_=nmodeTKey_", "", true, true)
+a::SendFnKey("{End}", "_=nmodeTKey_", "{End}", true, true)
b::SendFnKey("^{Left _n_}", "_=nmodeTKey_", "^+{Left _n_}")
d::SendFnKey("_nlinemodeOn_{Home}+{Down _n_}^x", "_=nmodeTKey_", "_nlinemodeOff_^x", true)
+d::SendFnKey("_nlinemodeOff_+{End}^x", "_=nmodeTKey_", "_nlinemodeOff_^x", true)
e::SendFnKey("{BS _n_}", "_=nmodeTKey_", "{BS _n_}", true)
f::SendFnKey("{PgDn _n_}", "_=nmodeTKey_", "+{PgDn _n_}")
+f::SendFnKey("{PgUp _n_}", "_=nmodeTKey_", "+{PgUp _n_}")
g::SendFnKey("^{Home}", "_=nmodeTKey_", "^+{Home}")
+g::SendFnKey("^{End}", "_=nmodeTKey_", "^+{End}")
h::SendFnKey("{Left _n_}", "_=nmodeTKey_", "+{Left _n_}")
i::SendFnKey("", "_=nmodeTKey_", "", true, true)
+I::SendFnKey("{Home}", "_=nmodeTKey_", "{Home}", true, true)
j::SendFnKey("{Down _n_}", "_=nmodeTKey_", "+{Down _n_}")
+j::SendFnKey("{End}{Del}", "_=nmodeTKey_", "{End}{Del}", true)
k::SendFnKey("{Up _n_}", "_=nmodeTKey_", "+{Up _n_}")
l::SendFnKey("{Right _n_}", "_=nmodeTKey_", "+{Right _n_}")
m::SendFnKey("{Home}", "_=nmodeTKey_", "+{Home}")
+6::SendFnKey("{Home}", "_=nmodeTKey_", "+{Home}")
,::SendFnKey("{End}", "_=nmodeTKey_", "+{End}")
+4::SendFnKey("{End}", "_=nmodeTKey_", "+{End}")
o::SendFnKey("{End}{Enter _n_}", "_=nmodeTKey_", "{End}{Enter _n_}", true, true)
+o::SendFnKey("{Home}{Enter _n_}{Up _n_}", "_=nmodeTKey_", "{Home}{Enter _n_}{Up _n_}", true, true)
p::SendFnKey("^v", "{Down}{Home}^v{Up}", "^v", true)
+p::SendFnKey("^v", "_=nmodeTKey_", "^v", true)
r::SendFnKey("{Del _n_}", "_=nmodeTKey_", "_nlinemodeOff_^x", true, true)
u::SendFnKey("^z", "_=nmodeTKey_", "^z")
+u::SendFnKey("^y", "_=nmodeTKey_", "^y")
w::SendFnKey("^{Right _n_}", "_=nmodeTKey_", "^+{Right _n_}")
x::SendFnKey("{Del _n_}", "_=nmodeTKey_", "_nlinemodeOff_^x", true)
+x::SendFnKey("{BS _n_}", "_=nmodeTKey_", "_nlinemodeOff_^x", true)
y::SendFnKey("_nlinemodeOn_{Home}+{Down _n_}^c{Up}", "_=nmodeTKey_", "_nlinemodeOff_^c", true)
~::
	if (IS_NMODE) {
		temp := ClipboardAll
		Clipboard =
		SendFnKey("+{Right _n_}^x", "_=nmodeTKey_", "^x", true)
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
	IS_LINE_SUBMODE := false
	IS_VMODE := false
	Send % A_ThisHotkey
return

SendNumberKey() {
	if (IS_NMODE) {
		VIM_REPEAT := VIM_REPEAT * 10 + A_ThisHotkey
		VIM_REPEAT := VIM_REPEAT > 100 ? 100 : VIM_REPEAT
		ShowModeTooltip()
	} else {
		Send % A_ThisHotkey
	}
}

RegExReplaceNotEqual(haystack, needleRegEx) {
	temp := haystack
	haystack := RegExReplace(haystack, needleRegEx, "")
	return temp != haystack, "123"
}

SendFnKey(nmodeTKey, nlinemodeTKey, vmodeTKey, clearVMode:=false, clearNMode:=false) {
	nlinemodeTKey := RegExReplace(nlinemodeTKey, "_=nmodeTKey_", nmodeTKey)
	if (IS_LINE_SUBMODE) {
		nmodeTKey := nlinemodeTKey
	}

	VIM_REPEAT := VIM_REPEAT < 1 ? 1 : VIM_REPEAT
	nmodeTKey := RegExReplace(nmodeTKey, "_n_", VIM_REPEAT)
	vmodeTkey := RegExReplace(vmodeTkey, "_n_", VIM_REPEAT)

	keys := (IS_NMODE ? (IS_VMODE ? vmodeTKey : nmodeTKey) : A_ThisHotkey)

	if (RegExReplaceNotEqual(keys, "_nlinemodeOn_")) {
		IS_LINE_SUBMODE := true	
	}
	if (RegExReplaceNotEqual(keys, "_nlinemodeOff_")) {
		IS_LINE_SUBMODE := false
	}
	keys := RegExReplace(keys, "_nlinemodeOn_", "")
	keys := RegExReplace(keys, "_nlinemodeOff_", "")
	Send % keys

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
	IS_LINE_SUBMODE := false
}
ShowModeTooltip() {
	WinGetPos, x, y, width, height, A
	if (IS_FNKEY_FIXED) {
		ToolTip % (IS_NMODE ? (IS_VMODE ? "V:" : "N:") : "I:") VIM_REPEAT ":" IS_LINE_SUBMODE, 0, height - 20
	} else {
		ToolTip
	}
}

#UseHook off
