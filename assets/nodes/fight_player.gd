extends CharacterBody2D

@export var RpgFightNode : Node2D

const INITIAL_ACC := 300.0
const ACC := 200.0
const MAX_SPEED := 600.0

var SPEED : float = 0.0

var last_direction : Vector2 = Vector2(0.0,0.0)

@export var PlayerCamera : Camera2D  
const CameraDiffMov : float = 30.0

@onready var SelectingPosition : Vector2 = global_position

var ActivatedSword : bool
@export var TimerSwordCooldown : Timer
@export var TimerSwordActivate : Timer
@export var PlayerSwordHitbox : Area2D
@export var CooldownChangeFightStateTimer : Timer

@export var LifeText : RichTextLabel
@export var InitialLife : int = 100
@onready var Life = InitialLife

func _physics_process(delta: float) -> void:
	LifeText.text = str(Life)
	if(RpgFightNode.FightState == Global.FightStates.Fighting):
		#Main movement
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
		#Sword
		if(Input.is_action_pressed("player_sword") && TimerSwordCooldown.is_stopped() && TimerSwordActivate.is_stopped()):
			TimerSwordCooldown.start()
			TimerSwordActivate.start()
			ActivatedSword = true
		if(TimerSwordActivate.is_stopped() && ActivatedSword):
			ActivatedSword = false
		PlayerSwordHitbox.visible = ActivatedSword
		PlayerSwordHitbox.monitoring = ActivatedSword
		
		move_and_slide()
	else:
		global_position.x = lerpf(global_position.x, SelectingPosition.x, 5*delta)
		global_position.y = lerpf(global_position.y, SelectingPosition.y, 5*delta)
		PlayerCamera.offset.x = lerpf(PlayerCamera.offset.x, 0.0, 5*delta)
		PlayerCamera.offset.y = lerpf(PlayerCamera.offset.y, 0.0, 5*delta)

func on_death() -> void:
	return
	

func _on_player_hitbox_area_entered(area: Area2D) -> void:
	on_death()


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	on_death()

func hit_enemy(enemy : Node2D) -> void:
	enemy.Life -= 10
	CooldownChangeFightStateTimer.start()

func sword_hit(body : Node2D) -> void:
	print("Sword hit: " + str(body))
	if(body.is_in_group("RpgEnemy")):
		hit_enemy(body)

func _on_player_sword_hitbox_body_entered(body: Node2D) -> void:
	sword_hit(body)


func _on_player_sword_hitbox_area_entered(area: Area2D) -> void:
	sword_hit(area)


func _on_cooldown_change_fight_state_timeout() -> void:
	RpgFightNode.FightState = Global.FightStates.Selecting
