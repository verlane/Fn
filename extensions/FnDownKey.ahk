#If IsVimMode("_fnDown_") && IsVimMode("_normal_") && gRepeat > 0
d::SendFnKey("{Home}+{Down _n_}+{Home}^x", "_lineCopy_")
y::SendFnKey("{Home}+{Down _n_}+{Home}^c{Up}", "_lineCopy_")
g::SendFnKey("^{Home}{Down _n_}{Up}")

#If IsVimMode("_fnDown_") && IsVimMode("_normal_") 
d::SendFnKey("{Home}+{End}^x{Del}", "", "_lineCopy_")
y::SendFnKey("{Home}+{End}^c{Home}", "", "_lineCopy_")
g::SendFnKey("^{Home}{Down _n_}{Up}")
t::SendFnKey("{End}")
c::SendFnKey("{BackSpace _n_}")
o::SendFnKey("{End}{Enter _n_}")
+o::SendFnKey("{Home}{Enter _n_}{Up _n_}")

#If IsVimMode("_fnDown_") && IsVimMode("_visual_") 
t::SendFnKey("+{End}")

#If IsVimMode("_fnDown_")
m::SendFnKey("{Enter}")
BS::SendFnKey("{Del}")
+y::SendFnKey("^a^c{Right}")
+x::SendFnKey("^a^x")