extends Node2D

@export var RpgFightNode : Node2D
var Players : Array[Node2D] = []
var SelectedPlayer = 0

var SelectedNodeTypePlayer : Global.PlayerTypes = Global.PlayerTypes.Regular

@export var Camera : Camera2D
const CameraFightOffset : float = 1.0
@onready var CameraSelectOffset : float = Camera.zoom.x

func go_select_next_player() -> void:
	SelectedPlayer += 1
	if(SelectedPlayer >= Players.size()):
		RpgFightNode.change_to_fight_state()

func _ready() -> void:
	for Child in get_children():
		if(Child.is_in_group("RpgPlayer")):
			Players.append(Child)


func _process(delta: float) -> void:
	if(RpgFightNode.FightState == Global.FightStates.Fighting):
		Camera.zoom.x = lerpf(Camera.zoom.x, CameraFightOffset, 2*delta)
		Camera.zoom.y = lerpf(Camera.zoom.y, CameraFightOffset, 2*delta)
	elif(RpgFightNode.FightState == Global.FightStates.Selecting):
		SelectedNodeTypePlayer = Players[SelectedPlayer].Type
		Camera.zoom.x = lerpf(Camera.zoom.x, CameraSelectOffset, 2*delta)
		Camera.zoom.y = lerpf(Camera.zoom.y, CameraSelectOffset, 2*delta)
		
		#Selecting Character Look
		for i in range(Players.size()):
			if(i == SelectedPlayer):
				Players[i].modulate = Color(Color.WHITE, 1.0)
				Players[i].z_index = 1
			else:
				Players[i].z_index = 0
				Players[i].modulate = Color(Color.WHITE, 0.2)

func _on_button_fight_button_down() -> void:
	if(RpgFightNode.FightState == Global.FightStates.Selecting):
		if(SelectedNodeTypePlayer == Global.PlayerTypes.Mague):
			RpgFightNode.CallSpell(Global.Spells.Ice)
		go_select_next_player()

func _on_button_item_pressed() -> void:
	pass # Replace with function body.


func _on_button_skip_button_up() -> void:
	if(RpgFightNode.FightState == Global.FightStates.Selecting):
		go_select_next_player()
