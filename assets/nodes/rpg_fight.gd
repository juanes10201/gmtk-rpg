extends Node2D

@export var UiAnim : AnimationPlayer
@export var FightPlayersNode : Node2D

var FightState = Global.FightStates.Selecting

func _ready() -> void:
	change_to_selecting_state()

func change_to_fight_state() -> void:
	FightState = Global.FightStates.Fighting
	UiAnim.play("fight_select")

func change_to_selecting_state() -> void:
	FightState = Global.FightStates.Selecting
	FightPlayersNode.SelectedPlayer = 0
	UiAnim.play("select_select")
