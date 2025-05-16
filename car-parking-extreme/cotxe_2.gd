extends CharacterBody2D

var direccio := Vector2(0, -1)
var velocitat := 0.0
var acceleracio := 200.0
var max_velocitat := 200.0
var fregament := 300.0
var voltes := 0
var pot_moure := true

func voltes_portades():
	voltes += 1

func _ready() -> void:
	position = Vector2(675, 550)
	
func _process(delta: float) -> void:
	if not pot_moure:
		return 
		
	var mov = Input.get_axis("frena", "accelera")
	$CPUParticles2D2.position = Vector2(480, 361)
	
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

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	velocitat = 0
	pot_moure = false
	$CPUParticles2D2.global_position = body.global_position
	$CPUParticles2D2.emitting = true
	$Timer.start()
	
func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://nivell2_completat.tscn")
