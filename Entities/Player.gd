extends Area2D
#DOCS: https://docs.godotengine.org/en/stable/getting_started/first_2d_game/03.coding_the_player.html
@export var speed = 100 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#function to get screen size 
	screen_size = get_viewport_rect().size
	
var animation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("deth"):
		$AnimatedSprite2D.play("deth")		
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		#animation = "walk_right"
		animation = "run_slow_right"
		
	if Input.is_action_pressed("move_right") and Input.is_action_pressed("sprint"):
		velocity.x += 1.5
		animation = "run_right"
		
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		#animation = "walk_left"
		animation = "run_slow_left"
		
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("sprint"):
		velocity.x -= 1.5
		animation = "run_left"
		
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		#animation = "walk_down"
		animation = "run_slow_down"
		
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("sprint"):
		velocity.y += 1.5
		animation = "run_down"
		
	if Input.is_action_pressed("move_down") and Input.is_action_pressed("injured"):
		speed = 20
		animation = "run_down_injured"
		
	if Input.is_action_pressed("move_up"):
			velocity.y -= 1
			animation = "run_slow_up"
	if Input.is_action_pressed("move_up") and Input.is_action_pressed("sprint"):
		velocity.y -= 1.5
		animation = "run_up"
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if animation: 
			$AnimatedSprite2D.play(animation)
	#else:
		#$AnimatedSprite2D.stop()
	#Changing player position based on velocity and delta time	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
