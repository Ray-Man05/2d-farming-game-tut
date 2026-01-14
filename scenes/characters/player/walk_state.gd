extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var current_speed: int

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()

	if direction == Vector2.UP:
		animated_sprite_2d.play("walk_back")
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play("walk_front")
	elif direction == Vector2.RIGHT:
		animated_sprite_2d.play("walk_right")
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play("walk_left")

	if direction != Vector2.ZERO:
		player.player_direction = direction

	if GameInputEvents.is_sprinting():
		current_speed = 2 * player.base_player_speed
	else:
		current_speed = player.base_player_speed

	player.velocity = direction * current_speed
	
	player.move_and_slide()


func _on_next_transitions() -> void:

# Little modification to preempt movement when the player wants to use a tool
	if GameInputEvents.use_tool():	
		if player.current_tool == DataTypes.Tools.AxeWood:
			transition.emit("Chopping")
		
		elif player.current_tool == DataTypes.Tools.TillGround:
			transition.emit("Tilling")

		elif player.current_tool == DataTypes.Tools.WaterCrops:
			transition.emit("Watering")

	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
