extends Node2D


var bg_color = global.monster_bg_color
var border_color = global.monster_border_color

#var style: StyleBoxFlat

func _ready() -> void:
	#style = StyleBoxFlat.new()
	#style.bg_color = Color("0a0a0a")
	#style.border_color = Color("8a1f1f")
		#i.add_theme_stylebox_override("panel", style)
	
	for i in get_children():
		var style = i.get_theme_stylebox("panel")
		style.bg_color = bg_color
		style.border_color = border_color
