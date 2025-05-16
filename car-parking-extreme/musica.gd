extends Node

var playing = false

func _ready():
	play_music()

func play_music():
	if not playing:
		$AudioStreamPlayer2D.play()
		playing = true

func stop_music():
	if playing:
		$AudioStreamPlayer2D.stop()
		playing = false

func toggle_music():
	if playing:
		stop_music()
	else:
		play_music()

func is_playing() -> bool:
	return playing
