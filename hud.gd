extends CanvasLayer

var coins_collected = 0

func _ready():
	
	$Label.text = "Coins: " + str(coins_collected)
	
func _on_coin_body_entered(body: CharacterBody3D) -> void:
	coins_collected = coins_collected + 1
	$Label.text = "Coins: " + str(coins_collected)
	
	
