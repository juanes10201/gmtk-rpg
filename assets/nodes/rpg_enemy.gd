extends Area2D

@export var LifeText : RichTextLabel

@export var InitialLife : int = 100.0
@onready var Life : int = InitialLife

@export var BulletAnim : AnimationPlayer
@export var RpgFightNode : Node2D

@export var AmountAttacks : int = 2
var CurrentAttack : int = 1
var ChangedAttack : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	LifeText.text = str(Life)
	if(RpgFightNode.FightState == Global.FightStates.Selecting):
		BulletAnim.play("RESET")
		if(!ChangedAttack):
			ChangedAttack = true
			CurrentAttack += 1
			if(CurrentAttack > AmountAttacks): CurrentAttack = 1
	elif(RpgFightNode.FightState == Global.FightStates.Fighting):
		BulletAnim.play("attack"+str(CurrentAttack))
		ChangedAttack = false
