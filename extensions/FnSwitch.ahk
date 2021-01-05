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

#If !IsVimMode("_fnDown_") && IsVimMode("_fnSwitch_")
SC002::F1 ; key 1
SC003::F2 ; key 2
SC004::F3 ; key 3
SC005::F4 ; key 4
SC006::F5 ; key 5
SC007::F6 ; key 6
SC008::F7 ; key 7
SC009::F8 ; key 8
SC00A::F9 ; key 9
SC00B::F10 ; key 0
SC00C::F11 ; key -
SC00D::F12 ; key =
