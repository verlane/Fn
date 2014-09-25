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
1::
*1::F1
+2::Send +{F2}
2::
*2::F2
+3::Send +{F3}
3::
*3::F3
+4::Send +{F4}
4::
*4::F4
+5::Send +{F5}
5::
*5::F5
+6::Send +{F6}
6::
*6::F6
+7::Send +{F7}
7::
*7::F7
+8::Send +{F8}
8::
*8::F8
+9::Send +{F9}
9::
*9::F9
+0::Send +{F10}
0::
*0::F10
+SC00C::Send +{F11}
SC00C::
*SC00C::F11
+=::Send +{F12}
=::
*=::F12
