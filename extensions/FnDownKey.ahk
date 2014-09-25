#If IsVimMode("_fnDown_") && IsVimMode("_normal_") && gRepeat > 0
d::SendFnKey("{Home}+{Down _n_}+{Home}^x", "_lineCopy_")
y::SendFnKey("{Home}+{Down _n_}+{Home}^c{Up}", "_lineCopy_")
g::SendFnKey("^{Home}{Down _n_}{Up}")

#If IsVimMode("_fnDown_") && IsVimMode("_normal_") 
r::SendFnKey("{Home}")
t::SendFnKey("{End}")
d::SendFnKey("{Home}+{End}^x{Del}", "", "_lineCopy_")
y::SendFnKey("{Home}+{End}^c{Home}", "", "_lineCopy_")
g::SendFnKey("^{Home}{Down _n_}{Up}")
c::SendFnKey("{BackSpace _n_}")
o::SendFnKey("{End}{Enter _n_}")
+o::SendFnKey("{Home}{Enter _n_}{Up _n_}")

#If IsVimMode("_fnDown_") && IsVimMode("_visual_") 
r::SendFnKey("+{Home}")
t::SendFnKey("+{End}")

#If IsVimMode("_fnDown_")
[::SendEscKey()
m::SendFnKey("{Enter}")
BS::SendFnKey("{Del}")
+y::SendFnKey("^a^c{Right}")
+x::SendFnKey("^a^x")
*h::Left
*l::Right
+1::Send +{F1}
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
Esc::SendFnKey("``")
+Esc::SendFnKey("~")

;^=::SoundSet +5  ; Increase master volume by 5%
;^-::SoundSet -5  ; Decrease master volume by 5%
