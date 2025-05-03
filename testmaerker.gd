extends Marker2D
const CHICK = preload("res://Scenes/NPCs/chick.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$".".add_child(CHICK.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
