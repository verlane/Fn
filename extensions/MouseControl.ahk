#If IsVimMode("_fnDown_") && !IsVimMode("_mouse_")
a::
	gModes.Insert(21, "_mouse_")
	SetVimMode("_mouse_")
	gShowToolTipCondition := "_fnFixed_|_fnDown_|_mouse_"
	gNoClearToolTipCondition := "_fnFixed_|_mouse_"
	ShowModeTooltip()
return

#If IsVimMode("_fnDown_") && IsVimMode("_mouse_")
a::
	SetVimMode("", "_mouse_")
	ShowModeTooltip()
return

#If !IsVimMode("_fnDown_") && IsVimMode("_mouse_")
Space::MouseClick
^Space::MouseClick right
h::AddMouseXY(-60, 0)
^h::AddMouseXY(-10, 0)
j::AddMouseXY(0, 60)
^j::AddMouseXY(0, 10)
k::AddMouseXY(0, -60)
^k::AddMouseXY(0, -10)
l::AddMouseXY(60, 0)
^l::AddMouseXY(10, 0)
AddMouseXY(X, Y) {
	MouseMove %X%, %Y%, 5, R
}
