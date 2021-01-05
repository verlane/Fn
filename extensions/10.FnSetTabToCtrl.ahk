#If IsVimMode("_fnDown_") && !IsVimMode("_fnCtrl_")
\::
	gModes.Insert(23, "_fnCtrl_")
	SetVimMode("_fnCtrl_")
	gShowToolTipCondition := "_fnFixed_|_fnCtrl_"
	gNoClearToolTipCondition := "_fnFixed_|_fnCtrl_"
	ShowModeTooltip()
return

#If IsVimMode("_fnDown_") && IsVimMode("_fnCtrl_")
\::
	SetVimMode("", "_fnCtrl_")
	ShowModeTooltip()
return

a::SendFnKey("^a")
b::SendFnKey("^b")
c::SendFnKey("^c")
d::SendFnKey("^d")
e::SendFnKey("^e")
f::SendFnKey("^f")
g::SendFnKey("^g")
h::SendFnKey("^h")
i::SendFnKey("^i")
j::SendFnKey("^j")
k::SendFnKey("^k")
l::SendFnKey("^l")
m::SendFnKey("^m")
n::SendFnKey("^n")
o::SendFnKey("^o")
p::SendFnKey("^p")
q::SendFnKey("^q")
r::SendFnKey("^r")
s::SendFnKey("^s")
t::SendFnKey("^t")
u::SendFnKey("^u")
v::SendFnKey("^v")
w::SendFnKey("^w")
x::SendFnKey("^x")
y::SendFnKey("^y")
z::SendFnKey("^z")
'::SendFnKey("^'")
`;::
  PostMessageSub("BSB.ahk", 2)	; show bsb gui
  SendFnKey("")
Return

#If IsVimMode("_fnCtrl_")
LShift::RShift
LCtrl::LWin

PostMessageSub(Receiver, Message) {
	oldTMM := A_TitleMatchMode, oldDHW := A_DetectHiddenWindows
	SetTitleMatchMode, 3
	DetectHiddenWindows, on
	PostMessage, 0x1001,%Message%,,, %Receiver% ahk_class AutoHotkeyGUI
	SetTitleMatchMode, %oldTMM%
	DetectHiddenWindows, %oldDHW%
}
