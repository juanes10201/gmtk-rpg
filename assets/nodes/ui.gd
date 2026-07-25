extends Control

@export var FightPlayersNode : Node2D
@export var ButtonFight : Button
@export var ButtonItem : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(FightPlayersNode.SelectedNodeTypePlayer == Global.PlayerTypes.Mague):
		ButtonFight.text = "Freeze\nCosts 20 lv"
		ButtonItem.text = "Faster Speed\nCosts 10 Lv"
	else:
		ButtonFight.text = "Fight"
		ButtonItem.text = "Item"
