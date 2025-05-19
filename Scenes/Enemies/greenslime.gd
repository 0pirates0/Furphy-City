extends CharacterBody2D


const SPEED = 50.0
var target

# ideas for future: follow a random point around player, set a range for slime
# to search for target
func _physics_process(delta):
	target = find_closest_target(["player", "animals"])
	if target:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func find_closest_target(group_names: Array) -> Node2D:
	var closest = null
	var closest_dist = INF
	
	for group in group_names:
		for entity in get_tree().get_nodes_in_group(group):
			if entity and entity != self:
				var dist = global_position.distance_to(entity.global_position)
				if dist < closest_dist:
					closest_dist = dist
					closest = entity
	
	return closest
