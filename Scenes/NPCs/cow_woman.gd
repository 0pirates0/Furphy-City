extends CharacterBody2D

var rng = RandomNumberGenerator.new()
const SPEED = 20.0
var initialpos
var target: Vector2
var is_waiting = false
@onready var animation_player = $AnimationPlayer
@onready var cow_woman = $"."


func _ready():
	initialpos = cow_woman.position
	new_target()

func _physics_process(delta):
	if is_waiting:
		return
	
	var direction = (target - cow_woman.position).normalized()
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
	var dst = cow_woman.position - target 
	if dst.length() < 2:
		velocity = Vector2(0,0)
		animation_player.stop()
		animation_player.play("idle")
		is_waiting = true
		await get_tree().create_timer(5).timeout
		animation_player.stop()
		new_target()
		is_waiting = false

func new_target():
	target.x = rng.randf_range(initialpos.x-50, initialpos.x+50)
	target.y = rng.randf_range(initialpos.y-75, initialpos.y+75)
