extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var velocity = Vector2()
var speedx = 0
var speedy = 0
var touch = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func kill(vector):
	velocity = vector
	apply_impulse(Vector2(0,0),velocity)
	apply_impulse(Vector2(0,0),-velocity*0.9)