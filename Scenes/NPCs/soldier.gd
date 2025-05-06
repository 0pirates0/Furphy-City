extends CharacterBody2D

var rng = RandomNumberGenerator.new()
const SPEED = 9
@onready var soldier = $"."
@onready var animation_player = $AnimationPlayer
var is_waiting
var target: Vector2
var inipos_x
var inipos_y

func _ready():
	inipos_x = soldier.position.x
	inipos_y = soldier.position.y
	target.y = inipos_y + 100


func _physics_process(delta):
	if is_waiting:
		return
	
	var direction = (target - soldier.position).normalized()
	velocity = direction*SPEED
	
	if direction.y > 0:
		animation_player.play("walk_down")
	elif direction.y < 0:
		animation_player.play("walk_up")
	
	var dst = target-soldier.position
	if dst.length() < 1:
		print(dst.length())
		is_waiting = true
		animation_player.play("idle")
		print(soldier.position)
		await get_tree().create_timer(3).timeout
		new_target()
		is_waiting = false
		print(target)

	move_and_slide()

func new_target():
	target.x = 0
	if soldier.position.y > 0:
		target.y = -115
	else:
		target.y = 100
