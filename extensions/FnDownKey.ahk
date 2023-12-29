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
i::SendFnKey("{Home}{Enter _n_}{Up _n_}")

#If IsVimMode("_fnDown_") && IsVimMode("_visual_")
e::SendFnKey("+{End}")
r::SendFnKey("+{Home}")
b::SendFnKey("+{Left _n_}")
+b::SendFnKey("^+{Left _n_}")
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
x::SendFnKey("^x", "_normal_", "_lineCopy_")
y::SendFnKey("^c", "_normal_", "_lineCopy_")

#If IsVimMode("_fnDown_")
Esc::SendFnKey("``")
+Esc::SendFnKey("~")
/::SendFnKey("{AppsKey}")
`::
  Winset, Alwaysontop, , A
  SendFnKey("")
return
,::SendFnKey("{Bs}")
.::SendFnKey("{Del}")
[::SendEscKey()
BS::SendFnKey("{Del}")
*SC002::SendFnKey("{F1}") ; key 1
*SC003::SendFnKey("{F2}") ; key 2
*SC004::SendFnKey("{F3}") ; key 3
*SC005::SendFnKey("{F4}") ; key 4
*SC006::SendFnKey("{F5}") ; key 5
*SC007::SendFnKey("{F6}") ; key 6
*SC008::SendFnKey("{F7}") ; key 7
*SC009::SendFnKey("{F8}") ; key 8
*SC00A::SendFnKey("{F9}") ; key 9
*SC00B::SendFnKey("{F10}") ; key 0
*SC00C::SendFnKey("{F11}") ; key -
*SC00D::SendFnKey("{F12}") ; key =
+SC002::SendFnKey("+{F1}") ; key 1
+SC003::SendFnKey("+{F2}") ; key 2
+SC004::SendFnKey("+{F3}") ; key 3
+SC005::SendFnKey("+{F4}") ; key 4
+SC006::SendFnKey("+{F5}") ; key 5
+SC007::SendFnKey("+{F6}") ; key 6
+SC008::SendFnKey("+{F7}") ; key 7
+SC009::SendFnKey("+{F8}") ; key 8
+SC00A::SendFnKey("+{F9}") ; key 9
+SC00B::SendFnKey("+{F10}") ; key 0
+SC00C::SendFnKey("+{F11}") ; key -
+SC00D::SendFnKey("+{F12}") ; key =
*h::SendFnKey("{Left}")
*j::SendFnKey("{Down}")
*k::SendFnKey("{Up}")
*l::SendFnKey("{Right}")
m::SendFnKey("{Enter}")
+x::SendFnKey("^a^x")
+y::SendFnKey("^a^c{Right}")
z::SendFnKey("^a^c{Right}")
WheelUp::
Right::
  Send {Volume_Up}
  SendFnKey("")
return
WheelDown::
Left::
  Send {Volume_Down}
  SendFnKey("")
return
; Up::
  ; SendFnKey("/")
; return
; +Up::
  ; SendFnKey("?")
; return
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
Up::
^Up::
  Send {Media_Play_Pause}
  SendFnKey("")
return
^Down::
  Send {Media_Stop}
  SendFnKey("")
return
b::SendFnKey("{Left _n_}")
+b::SendFnKey("^{Left _n_}")
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
+i::SendFnKey("{Home}", "_insert_")
j::SendFnKey("{Down _n_}")
+j::SendFnKey("{End}{Del}{End}", "", "", gRepeat)
k::SendFnKey("{Up _n_}")
l::SendFnKey("{Right _n_}")
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

^c::
^x::
	if (IsVimMode("_visual_")) {
		SetVimMode("_normal_", "_visualLine_lineCopy_")
	}
	Send % A_ThisHotkey
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
n::SendFnKey("^{BS}")
