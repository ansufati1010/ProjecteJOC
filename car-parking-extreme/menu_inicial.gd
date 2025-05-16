extends Control

func _ready():
	get_tree().get_root().add_child(self)
	self.get_parent().remove_child(self)

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://nivell1.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://nivell2.tscn")


var volum_activat := true

func _on_button_3_pressed() -> void:
	if volum_activat:
		$VolumOn.texture = load("res://mute_16105264.png")
		$AudioStreamPlayer.stop()
	else:
		$VolumOn.texture = load("res://volum_on.png")
		$AudioStreamPlayer.play()

	volum_activat = !volum_activat
