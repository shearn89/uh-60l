dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path..'ASN128/indicator/uiDefines.lua')
dofile(LockOn_Options.script_path..'ASN128/indicator/pageDefines.lua')
SetScale(METERS)
verts = {}
dx=.0145
dy=.0084
verts [1]= {-dx,-dy}
verts [2]= {-dx,dy}
verts [3]= {dx,dy}
verts [4]= {dx,-dy}

local base 			 = CreateElement "ceMeshPoly"
base.name 			 = "base"
base.vertices 		 = verts
base.indices 		 = {0,1,2,2,3,0}
base.init_pos		 = center
base.init_rot		 = rotation
base.material		 = MakeMaterial(nil,{255,3,3,255})
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level			 = 5
base.isdraw			 = true
base.change_opacity  = false
base.isvisible		 = false
base.element_params  = {"ASN128_POWER", "ASN128_PAGE"}
base.controllers     = {{"parameter_in_range",0,0.9,1.1}, {"parameter_in_range",1,GSTKNAVM_1}}
Add(base)

createTextLine(line1Pos, {"ASN128_GENERIC_TOP_LINE"}, {{"text_using_parameter",0, 0}}, base)
createTextLine(line2Pos, {"ASN128_GS"}, {{"text_using_parameter",0, 0}}, base)
createTextLine(line3Pos, {"ASN128_TK"}, {{"text_using_parameter",0, 0}}, base)
createTextLine(line7Pos, {"ASN128_DTK"}, {{"text_using_parameter",0, 0}}, base, "RightCenter")
createHardcodedTextLine(line4Pos, "GPS:Y NAV:C", base)

createTextLine(navLinePos, {"ASN128_MORE"}, {{"text_using_parameter",0, 0}}, base, "RightCenter")
