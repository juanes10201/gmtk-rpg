extends CharacterBody2D

const INITIAL_ACC := 200.0
const ACC := 100.0
const MAX_SPEED := 400.0

var SPEED : float = 0.0

var last_direction : Vector2 = Vector2(0.0,0.0)

@export var PlayerCamera : Camera2D  
const CameraDiffMov : float = 30.0

func _physics_process(delta: float) -> void:
	var direction_horiz := Input.get_axis("ui_left", "ui_right")
	var direction_vert := Input.get_axis("ui_up", "ui_down")
	var direction : Vector2 = Vector2(direction_horiz, direction_vert)
	if direction && SPEED < MAX_SPEED:
		SPEED += ACC*delta
		SPEED = clamp(SPEED, INITIAL_ACC, MAX_SPEED)
	else:
		SPEED = lerpf(SPEED, 0.0, 5*delta)
	if(direction): last_direction = direction.normalized()
	PlayerCamera.offset.x = lerpf(PlayerCamera.offset.x, CameraDiffMov*last_direction.x, 5*delta)
	PlayerCamera.offset.y = lerpf(PlayerCamera.offset.y, CameraDiffMov*last_direction.y, 5*delta)
	velocity = last_direction*SPEED
	move_and_slide()
