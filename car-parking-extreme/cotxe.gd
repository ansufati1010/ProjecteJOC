extends CharacterBody2D

var direccio := Vector2(0, -1)
var velocitat := 0.0
var acceleracio := 200.0
var max_velocitat := 200.0
var fregament := 300.0
var voltes := 0

func voltes_portades():
	voltes += 1

func _ready() -> void:
	position = Vector2(152, 566)

func _process(delta: float) -> void:
	var mov = Input.get_axis("frena", "accelera")

	if mov != 0:
		velocitat += mov * acceleracio * delta
	else:
		if velocitat > 0:
			velocitat = max(velocitat - fregament * delta, 0)
		elif velocitat < 0:
			velocitat = min(velocitat + fregament * delta, 0)
			
	velocitat = clamp(velocitat, -150, max_velocitat)

	velocity = direccio * velocitat

	if Input.is_action_pressed("moure_esquerra"):
		direccio = direccio.rotated(-0.05)
	if Input.is_action_pressed("moure_dreta"):
		direccio = direccio.rotated(0.05)

	move_and_slide()

	anima(direccio, delta)

func anima(direccio: Vector2, delta: float):
	rotation = direccio.angle() + deg_to_rad(+90)

func _on_area_2d_body_entered(body: CharacterBody2D):
	get_tree().change_scene_to_file("res://nivell_completat.tscn")
