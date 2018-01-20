# script: bird

extends RigidBody2D

onready var state = FlyingState.new(self)

var speed = 50

const STATE_FLYING   = 0
const STATE_FLAPPING = 1
const STATE_HIT      = 2
const STATE_GROUNDED = 3

func _ready():
	set_process_input(true)
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	state.update(delta)
	pass


func _input(event):
	state.input(event)
	pass

func set_state(new_state):
	state.exit()
	
	if new_state == STATE_FLYING:
		state = FlyingState.new(self)
	elif new_state == STATE_FLAPPING:
		state = FlappingState.new(self)
	elif new_state == STATE_HIT:
		state = HitState.new(self)
	elif new_state == STATE_GROUNDED:
		state = GroundedState.new(self)
	pass

func get_state():
	if state extends FlyingState:
		return STATE_FLYING
	if state extends FlappingState:
		return STATE_FLAPPING
	if state extends HitState:
		return STATE_HIT
	if state extends GroundedState:
		return STATE_GROUNDED
	pass
# class flysinstate <----===========================---->

class FlyingState:
	var bird
	var prev_gravity_scale
	
	func _init(bird):
		self.bird = bird
		bird.get_node("anim").play("flying")
		bird.set_linear_velocity(Vector2(bird.speed, bird.get_linear_velocity().y))
		
		prev_gravity_scale = bird.get_gravity_scale()
		bird.set_gravity_scale(0)
		pass
	
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		bird.set_gravity_scale(prev_gravity_scale)
		pass

# class flappingstate <----===========================---->

class FlappingState:
	var bird
	
	func _init(bird):
		self.bird = bird
		
		bird.set_linear_velocity(Vector2(bird.speed, bird.get_linear_velocity().y))
		pass
	
	func update(delta):
		if rad2deg(bird.get_rot()) > 30:
			bird.set_rot(deg2rad(30))
			bird.set_angular_velocity(0)
		
		if bird.get_linear_velocity().y > 0:
			bird.set_angular_velocity(1.5)
		pass
	
	func input(event):
		if event.is_action_pressed("flap"):
			flap() 
		pass
	
	func flap():
		bird.set_linear_velocity(Vector2(bird.get_linear_velocity().x, -150))
		bird.set_angular_velocity(-3)
		bird.get_node("anim").play("flap")
		pass
	
	func exit():
		pass

# class hitstate <----===========================---->

class HitState:
	var bird
	
	func _init(bird):
		self.bird = bird
		pass
	
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		pass

# class groundedstate <----===========================---->

class GroundedState:
	var bird
	
	func _init(bird):
		self.bird = bird
		pass
	
	func update(delta):
		pass
	
	func input(event):
		pass
	
	func exit():
		pass