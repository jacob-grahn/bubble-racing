extends Sprite


func _ready():
	get_viewport().connect("size_changed", self, "_on_size_changed")
	_on_size_changed()


func _on_size_changed():
	var size = get_viewport().get_visible_rect().size
	var textureSize = texture.get_size()
	var scale = size / textureSize
	set_scale(scale)
