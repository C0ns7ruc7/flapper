# script: bird

extends RigidBody2D

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if rad2deg(get_rot()) > 30:
		set_rot(deg2rad(30))
	
	if get_linear_velocity().y > 0:
		set_angular_velocity(1.5)
	pass

func flap():
	set_linear_velocity(Vector2(get_linear_velocity().x, -150))
	set_angular_velocity(-3)
	pass

func _input(event):
	if event.is_action_pressed("flap"):
		flap()
	pass
