extends Area2D

@export var LifeText : RichTextLabel

@export var InitialLife : int = 100.0
@onready var Life : int = InitialLife

@export var BulletAnim : AnimationPlayer
@export var RpgFightNode : Node2D

@export var AmountAttacks : int = 2
var CurrentAttack : int = 1
var ChangedAttack : bool = true

var AnimPaused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func freeze(sec : float) -> void:
	print("Freezed enemy: " + str(self) + "; for " + str(sec))
	BulletAnim.pause()
	AnimPaused = true
	await get_tree().create_timer(sec).timeout
	AnimPaused = false
	BulletAnim.play()
	print("resumed")

func play_anim(anim : String) -> void:
	if(AnimPaused): return
	BulletAnim.play(anim)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	LifeText.text = str(Life)
	if(RpgFightNode.FightState == Global.FightStates.Selecting):
		play_anim("RESET")
		if(!ChangedAttack):
			ChangedAttack = true
			CurrentAttack += 1
			if(CurrentAttack > AmountAttacks): CurrentAttack = 1
	elif(RpgFightNode.FightState == Global.FightStates.Fighting):
		play_anim("attack"+str(CurrentAttack))
		ChangedAttack = false
