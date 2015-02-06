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
+1::Send +{F1}
2::
*2::F2
+2::Send +{F2}
3::
*3::F3
+3::Send +{F3}
4::
*4::F4
+4::Send +{F4}
5::
*5::F5
+5::Send +{F5}
6::
*6::F6
+6::Send +{F6}
7::
*7::F7
+7::Send +{F7}
8::
*8::F8
+8::Send +{F8}
9::
*9::F9
+9::Send +{F9}
0::
*0::F10
+0::Send +{F10}
SC00C::
*SC00C::F11
+SC00C::Send +{F11}
=::
*=::F12
+=::Send +{F12}
