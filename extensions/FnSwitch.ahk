#If IsVimMode("_fnDown_") && !IsVimMode("_fnSwitch_")
q::
	gModes.Insert(21, "_fnSwitch_")
	SetVimMode("_fnSwitch_")
	gShowToolTipCondition := "_fnFixed_|_fnDown_|_fnSwitch_"
	gNoClearToolTipCondition := "_fnFixed_|_fnSwitch_"
	ShowModeTooltip()
return

#If IsVimMode("_fnDown_") && IsVimMode("_fnSwitch_")
q::
	SetVimMode("", "_fnSwitch_")
	ShowModeTooltip()
return

#If IsVimMode("_fnSwitch_")
1::SendFnKeyForce("{F1}")
2::SendFnKeyForce("{F2}")
3::SendFnKeyForce("{F3}")
4::SendFnKeyForce("{F4}")
5::SendFnKeyForce("{F5}")
6::SendFnKeyForce("{F6}")
7::SendFnKeyForce("{F7}")
8::SendFnKeyForce("{F8}")
9::SendFnKeyForce("{F9}")
0::SendFnKeyForce("{F10}")
-::SendFnKeyForce("{F11}")
=::SendFnKeyForce("{F12}")
