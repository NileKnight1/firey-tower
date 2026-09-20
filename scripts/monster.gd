extends Node2D

#var style: StyleBoxFlat


var bg_colors = [
	["0a0a0a","8a1f1f"],
	["0a0d0a","4a5c2e"],
	["0a0c0d","3d5a66"],
	["08070a","3d1f5c"],
	
]

var style_num = global.monster_style

func set_style(num):
	style_num = num
	for i in $sprite.get_children():
		var style = i.get_theme_stylebox("panel")
		style.bg_color = Color(bg_colors[style_num][0])
		style.border_color = Color(bg_colors[style_num][1])

func _ready() -> void:
	set_style(style_num)
	#style = StyleBoxFlat.new()
	#style.bg_color = Color("0a0a0a")
	#style.border_color = Color("8a1f1f")
		#i.add_theme_stylebox_override("panel", style)
