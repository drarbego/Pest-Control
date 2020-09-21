extends KinematicBody2D


var direction = Vector2(-1,-1)
var speed = 500.0

func _ready():
	pass # Replace with function body.

func init(pos: Vector2, dir: Vector2):
	position = pos
	direction = dir

func _physics_process(delta):
	var motion = direction * speed * delta
	var collision = move_and_collide(motion)

	if collision:
		direction = direction.bounce(collision.normal)