extends Sprite2D

var default_texture =  State.default_char_texture.path
func _ready():
	var texture_path = default_texture
	var new_texture = load(texture_path)
	if new_texture:
		texture = new_texture
	else:
		print("Error: Could not load texture from: ", texture_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var texture_path = default_texture
	var new_texture = load(texture_path)
	if new_texture:
		texture = new_texture
	else:
		print("Error: Could not load texture from: ", texture_path)


func _on_character_selection_load_texture(char_texture):
	default_texture = char_texture.path
