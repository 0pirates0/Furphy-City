extends CharacterBody2D

var rng = RandomNumberGenerator.new()
const SPEED = 6
@onready var oldman = $"."
@onready var animation_player = $AnimationPlayer
var is_waiting
var target: Vector2
var inipos_x
var inipos_y

func _ready():
	inipos_x = oldman.position.x
	inipos_y = oldman.position.y
	
	new_target()

func _physics_process(delta):
	if is_waiting:
		return
	
	var direction = (target - oldman.position).normalized()
	velocity = direction*SPEED
	if abs(direction.x)>abs(direction.y):
		if direction.x > 0:
			animation_player.play("waalk_right")
		else:
			animation_player.play("walk_left")
	else:
		if direction.y > 0:
			animation_player.play("walk_down")
		else:
			animation_player.play("walk_up")
	
	var dst = target-oldman.position
	if dst.length() < 3:
		is_waiting = true
		animation_player.play("idle")
		await get_tree().create_timer(5).timeout
		new_target()
		is_waiting = false
	

	move_and_slide()

func new_target():
	target.x = rng.randf_range(inipos_x-75, inipos_x+75)
	target.y = rng.randf_range(inipos_y-50, inipos_y+50)
