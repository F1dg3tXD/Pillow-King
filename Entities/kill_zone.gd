extends Area3D


# Called when a body enters the kill zone. If it's the player, respawn it.
func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D or body.is_in_group("Player") or body.name == "Player":
		if Engine.has_singleton("Player"):
			var player = Engine.get_singleton("Player")
			player.global_transform = _get_spawn_point().global_transform if _get_spawn_point() else player.global_transform
			if player is CharacterBody3D:
				player.velocity = Vector3.ZERO
				player.reset_physics_interpolation()
			return
		# Fallback: try to respawn the body that entered
		if body.has_method("respawn"):
			body.respawn()
			return
		var sp := _get_spawn_point()
		if sp:
			body.global_transform = sp.global_transform
			if body is CharacterBody3D:
				body.velocity = Vector3.ZERO
				body.reset_physics_interpolation()


func _get_spawn_point() -> Node3D:
	var sp := get_tree().get_first_node_in_group("SpawnPoint")
	if sp is Node3D:
		return sp
	return get_tree().current_scene.find_child("SpawnPoint", true, false) as Node3D
