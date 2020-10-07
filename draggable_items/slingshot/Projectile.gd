extends KinematicBody2D


var explosion_class = preload("res://draggable_items/slingshot/Explosion.tscn")

var direction = Vector2.UP
var speed = 500.0
var distance_span

signal exploded(explosion)

func init(pos: Vector2, dir: Vector2, dist_span: float):
	self.position = pos
	self.direction = dir
	self.distance_span = dist_span

func _physics_process(delta):
	var motion = direction * speed * delta
	var collision = move_and_collide(motion)

	if collision:
		self.direction = self.direction.bounce(collision.normal)
		if collision.collider.has_method("handle_projectile_collision"):
			collision.collider.handle_projectile_collision(self, collision)

		destroy()

func _ready():
	$Timer.set_wait_time(distance_span / speed)
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	$Timer.start()

func _on_Timer_timeout():
	destroy()

func destroy():
	var explosion = explosion_class.instance()
	explosion.position = self.position
	emit_signal("exploded", explosion)
	queue_free()
