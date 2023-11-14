extends KinematicBody2D

signal keepMoving(velocity,speed)
export var speed = 400.0 
export var gravity = 400.0
var screen_size
var inverted = 1
var velocity = Vector2.ZERO 
var velocityDelay = Vector2.ZERO
export var devMode = false
export var flipDelayDuration = 10
var flipDelay = 0
var forward = false 
var alive = true 
var gravitySwitchBoundryStop = true 
#up_direction = 

func _ready():
	screen_size = get_viewport_rect().size
	#print(screen_size)
#	print(position)
	#velocity.y = 1 
func _animation(collision):
	$AnimatedSprite.flip_v = inverted < 0
	
	if (velocity.x > 6 or velocity.x < -6) and (velocityDelay.x > 6 or velocityDelay.x < -6):
		$AnimatedSprite.animation = "catWalking"
		$AnimatedSprite.flip_h = forward
	else:
		$AnimatedSprite.animation = "catDefault"
		$AnimatedSprite.flip_h = forward
	velocityDelay = velocity
func _process(delta):
	if flipDelay > 0:
		flipDelay -= 1
	#print(screen_size)
	
	if devMode:
		if Input.is_action_pressed("ui_right"):
			velocity.x += 10 
			forward = true
		elif Input.is_action_pressed("ui_left"):
			velocity.x -= 10
			forward = false
		else:
			velocity.x = 0
	else:
		forward = true
		velocity.x += 10

# inverts gravity when keypress
	if (Input.is_action_pressed("ui_up")) and gravitySwitchBoundryStop and flipDelay < 1:
		gravitySwitchBoundryStop = false
		velocity.y *= -1
		inverted *= -1
		flipDelay = flipDelayDuration
		#print(velocity.y)
		#print(inverted)

	# aggusts speed of velocity
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed 
		
	#if moving slow stops charachter
	if velocity.x < 1 && velocity.x > -1:
		velocity.x = 0 
	
	#aggusts gravity
	velocity.y += ((gravity * delta) * inverted) 
	
	var movement = velocity
	if (((position.y < (screen_size.y /9)) and inverted < 0) or ((position.y > (screen_size.y *4) /4) and inverted > 0) and alive):
		if (position.x > (2* screen_size.x) /5) : 
			movement.x = 0
			movement.y = 0 
			emit_signal("keepMoving", velocity * delta)
		else:
			movement.y = 0
			velocity.x = 0 
			emit_signal("keepMoving", velocity * delta )
			velocity.x = movement.x
	elif (position.x > (screen_size.x) /5) && forward and alive:
		movement.x = 0
		velocity.y = 0 
		emit_signal("keepMoving", velocity * delta)
		velocity.y = movement.y
	#print(movement)
	#print("1")
	#print(velocity)
	#movement = startpoint.dir
	
	var collision = move_and_collide(movement*delta)
	#print(delta)
	if collision:
		gravitySwitchBoundryStop = true
		velocity = velocity.slide(collision.normal)
	else:
		gravitySwitchBoundryStop = false
	_animation(collision)

