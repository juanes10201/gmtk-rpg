extends Node

enum FightStates{
	Selecting,
	Fighting
}

enum PlayerTypes{
	Regular,
	Mague,
	Ice
}

enum Spells{
	Ice,
	Heal
}

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
