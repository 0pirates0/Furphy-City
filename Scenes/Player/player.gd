extends CharacterBody2D
const SPEED = 150.0
@onready var animation_player = $AnimationPlayer
@onready var bodyani = $bodyani
@onready var hairani = $hairani


func _physics_process(delta):

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var directiony = Input.get_axis("ui_up", "ui_down")
	if directiony:
		velocity.y = directiony * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if velocity == Vector2(0,0):
		animation_player.play("idle")
	else:
		animation_player.play("walk")
		if direction == 1:
			bodyani.flip_h = false
			hairani.flip_h = false
		elif direction == -1:
			bodyani.flip_h = true
			hairani.flip_h = true

	move_and_slide()


func _on_spawneractivate_body_entered(body):
	var t = create_tween()
	if body.is_in_group("player"):
		t.tween_property($"../../spawner1", "modulate:a", 0, 1.0)
		t.tween_property($"../../spellpart1", "modulate:a", 1, 1.0)


func _on_spawneractivate_2_body_entered(body):
	var t = create_tween()
	if body.is_in_group("player"):
		t.tween_property($"../../spawner2", "modulate:a", 0, 1.0)
		t.tween_property($"../../spellpart2", "modulate:a", 1, 1.0)


func _on_spawneractivate_body_exited(body):
	var t = create_tween()
	if body.is_in_group("player"):
		t.tween_property($"../../spawner1", "modulate:a", 1, 1.0)
		t.tween_property($"../../spellpart1", "modulate:a", 0, 1.0)


func _on_spawneractivate_2_body_exited(body):
	var t = create_tween()
	if body.is_in_group("player"):
		t.tween_property($"../../spawner2", "modulate:a", 1, 1.0)
		t.tween_property($"../../spellpart2", "modulate:a", 0, 1.0)
