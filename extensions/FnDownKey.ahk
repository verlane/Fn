#If IsVimMode("_fnDown_") && IsVimMode("_normal_") 
d::SendFnKey("{Home}+{Down _n_}+{Home}^x", "_lineCopy_")
y::SendFnKey("{Home}+{Down _n_}+{Home}^c{Up}", "_lineCopy_")
g::SendFnKey("^{Home}{Down _n_}{Up}")
t::SendFnKey("{End}")
c::SendFnKey("{BackSpace}")
o::SendFnKey("{End}{Enter _n_}")

#If IsVimMode("_fnDown_") && IsVimMode("_visual_") 
t::SendFnKey("+{End}"	)
