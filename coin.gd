extends Area3D

func _ready():
	connect("body_entered", _on_body_entered)

func _process(delta):
	rotate_y(0.01)

func _on_body_entered(body):
	if body.name == "CharacterBody3D": 
		print("Coin collected!")
		$CoinSound.play()
		$coin_obj.queue_free()
		
		
func _on_coin_sound_finished() -> void:
	queue_free()
