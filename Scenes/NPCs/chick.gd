extends CharacterBody2D

var rng = RandomNumberGenerator.new()
const SPEED = 5.0
@onready var chick = $"."
@onready var animation_player = $AnimationPlayer

var is_waiting = false

var initial_x: float
var initial_y: float

var target: Vector2

func _ready():
	initial_x = chick.position.x
	initial_y = chick.position.y
	
	new_target()


func _physics_process(delta):
	
	if is_waiting:
		return
	
	var direction = (target-chick.position).normalized()
	if abs(direction.x) > abs(direction.y):
		velocity = direction*SPEED
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
			animation_player.play("walk_side")
		else:
			$AnimatedSprite2D.flip_h = false
			animation_player.play("walk_side")
	else:
		velocity = direction*SPEED
		if direction.y < 0:
			animation_player.play("walk_up")
		else:
			animation_player.play("walk_side")
	
	move_and_slide()
	
	if chick.position == target:
		velocity = Vector2(0,0)
		is_waiting = true
		get_tree().create_timer(5).timeout
		new_target()
		is_waiting = false


func new_target():
	var vecx = rng.randf_range(initial_x-100, initial_x+100)
	var vecy = rng.randf_range(initial_y-30, initial_y+30)
	
	target = Vector2(vecx, vecy)
