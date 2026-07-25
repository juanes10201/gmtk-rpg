extends Node2D

@export var UiAnim : AnimationPlayer
@export var FightPlayersNode : Node2D
@export var MainPlayer : Node2D

var FightState = Global.FightStates.Selecting
var UsingIceInTurn : bool = false

@export var AllEnemiesNode : Node2D
var EnemiesList : Array[Node2D] 

func CallSpell(Spell : Global.Spells) -> void:
	if(Spell == Global.Spells.Ice):
		UsingIceInTurn = true
	elif(Spell == Global.Spells.Heal):
		MainPlayer.life += 20

func _ready() -> void:
	change_to_selecting_state()
	for Enemy in AllEnemiesNode.get_children():
		EnemiesList.append(Enemy)

func change_to_fight_state() -> void:
	FightState = Global.FightStates.Fighting
	UiAnim.play("fight_select")
	if(UsingIceInTurn):
		await get_tree().create_timer(2).timeout
		ice_enemy(3.0)

func ice_enemy(sec : float) -> void:
	for Enemy in EnemiesList:
		Enemy.freeze(sec)
		Global.wait(0.2)
	Global.wait(1.0)

func change_to_selecting_state() -> void:
	FightState = Global.FightStates.Selecting
	FightPlayersNode.SelectedPlayer = 0
	UiAnim.play("select_select")
