extends Area3D

# How fast the bullet flies, in meters per second.
@export var speed = 30
# How long the bullet lives before it disappears, in seconds.
@export var lifetime = 1.0

# The direction the bullet flies in (set by the player when shooting).
var direction = Vector3.FORWARD


# Runs every physics frame.
func _physics_process(delta):
	# 1. Move forward a little bit in our direction.
	#    (direction x speed x elapsed time = distance to move this frame)
	position += direction * speed * delta

	# 2. Count down the lifetime and delete the bullet when time is up,
	#    so bullets that miss don't pile up forever.
	lifetime -= delta
	if lifetime <= 0:
		queue_free()


# Called automatically when the bullet touches a body (body_entered signal).
func _on_body_entered(body):
	# If the body we touched is a mob...
	if body.is_in_group("mob"):
		# ...kill it the same way as jumping on it.
		# squash() emits the "squashed" signal, so the score goes up by 1 too.
		body.squash()
		# The bullet has done its job, so delete it as well.
		queue_free()
