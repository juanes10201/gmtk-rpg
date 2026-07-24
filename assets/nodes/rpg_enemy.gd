extends Area2D

@export var LifeText : RichTextLabel

@export var InitialLife : int = 100.0
@onready var Life : int = InitialLife

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	LifeText.text = str(Life)
