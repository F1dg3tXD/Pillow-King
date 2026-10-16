extends Node3D


var player: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.has_singleton("Player"):
		player = Engine.get_singleton("Player")
	else:
		player = get_tree().root.get_node_or_null("Player")
	
	if player == null:
		push_warning("SpawnPoint: Could not find Player autoload. Make sure Player is set as an autoload.")
		return
	
	# Place the player at this spawn point after the map loads.
	player.global_transform = global_transform
	if player is CharacterBody3D:
		player.velocity = Vector3.ZERO
		player.reset_physics_interpolation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
