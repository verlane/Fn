#If IsVimMode("_fnDown_") && IsVimMode("_normal_") && gRepeat > 0
d::SendFnKey("{Home}+{Down _n_}+{Home}^x", "_lineCopy_")
y::SendFnKey("{Home}+{Down _n_}+{Home}^c{Up}", "_lineCopy_")
g::SendFnKey("^{Home}{Down _n_}{Up}")

#If IsVimMode("_fnDown_") && IsVimMode("_normal_") 
e::SendFnKey("{End}")
r::SendFnKey("{Home}")
d::SendFnKey("{Home}+{End}^x{Del}", "", "_lineCopy_")
y::SendFnKey("{Home}+{End}^c{Home}", "", "_lineCopy_")
g::SendFnKey("^{Home}{Down _n_}{Up}")
c::SendFnKey("{BackSpace _n_}")
o::SendFnKey("{End}{Enter _n_}")
+o::SendFnKey("{Home}{Enter _n_}{Up _n_}")

#If IsVimMode("_fnDown_") && IsVimMode("_visual_") 
e::SendFnKey("+{End}")
r::SendFnKey("+{Home}")

#If IsVimMode("_fnDown_")
[::SendEscKey()
m::SendFnKey("{Enter}")
BS::SendFnKey("{Del}")
z::SendFnKey("^a^c{Right}")
+y::SendFnKey("^a^c{Right}")
+x::SendFnKey("^a^x")
*h::SendFnKey("{Left}")
*j::SendFnKey("{Down}")
*k::SendFnKey("{Up}")
*l::SendFnKey("{Right}")
1::
*1::SendFnKey("{F1}")
+1::SendFnKey("+{F1}")
2::
*2::SendFnKey("{F2}")
+2::SendFnKey("+{F2}")
3::
*3::SendFnKey("{F3}")
+3::SendFnKey("+{F3}")
4::
*4::SendFnKey("{F4}")
+4::SendFnKey("+{F4}")
5::
*5::SendFnKey("{F5}")
+5::SendFnKey("+{F5}")
6::
*6::SendFnKey("{F6}")
+6::SendFnKey("+{F6}")
7::
*7::SendFnKey("{F7}")
+7::SendFnKey("+{F7}")
8::
*8::SendFnKey("{F8}")
+8::SendFnKey("+{F8}")
9::
*9::SendFnKey("{F9}")
+9::SendFnKey("+{F9}")
0::
*0::SendFnKey("{F10}")
+0::SendFnKey("+{F10}")
+SC00C::SendFnKey("+{F11}") ; KEY:-
SC00C::
*SC00C::SendFnKey("{F11}")
+=::SendFnKey("+{F12}")
=::
*=::SendFnKey("{F12}")
Esc::SendFnKey("``")
+Esc::SendFnKey("~")
`;::AppsKey
`::
  Winset, Alwaysontop, , A
  SendFnKey("")
return

Right::
  Send {Volume_Up}
  SendFnKey("")
return
Left::
  Send {Volume_Down}
  SendFnKey("")
return
Down::
  Send {Volume_Mute}
  SendFnKey("")
return
^Left::
  Send {Media_Prev}
  SendFnKey("")
return
^Right::
  Send {Media_Next}
  SendFnKey("")
return
^Up::
  Send {Media_Play_Pause}
  SendFnKey("")
return
^Down::
  Send {Media_Stop}
  SendFnKey("")
return
