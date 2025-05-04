extends CharacterBody2D

var rng = RandomNumberGenerator.new()
const SPEED = 8.0
@onready var animation_player = $AnimationPlayer
@onready var girl = $"."
var is_waiting = false
var target: Vector2
var initialpos_x: float
var initialpos_y: float

func _ready():
	initialpos_x = girl.position.x
	initialpos_y = girl.position.y
	
	new_target()

func _physics_process(delta):
	if is_waiting:
		return
	
	var direction = (target-girl.position).normalized()
	velocity = direction*SPEED
	if abs(direction.x) > abs(direction.y):
		if direction.x <= 0:
			animation_player.play("walk_left")
		else:
			animation_player.play("walk_right")
	else:
		if direction.y <= 0:
			animation_player.play("walk_up")
		else:
			animation_player.play("walk_down")

	move_and_slide()
	
	var dst = target-girl.position
	if dst.length() < 1:
		is_waiting = true
		animation_player.play("idle")
		await get_tree().create_timer(5).timeout
		new_target()
		is_waiting = false

func new_target():
	target.x = rng.randf_range(initialpos_x-100, initialpos_x+100)
	target.y = rng.randf_range(initialpos_y-30, initialpos_y+30)
	
