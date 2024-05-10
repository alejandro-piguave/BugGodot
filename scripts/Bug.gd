extends CharacterBody2D

const SPEED = 10000.0

var current_animation = "red"

var dead = false

func _ready():
	$Sprite.play(current_animation)
	$StreamPlayer.stream = load("res://sounds/bug_walk.mp3")

func _physics_process(delta):
	
	if dead: 
		return
	
	var direction = Input.get_vector("move_left","move_right","move_up", "move_down")
	if direction.x == 0 and direction.y == 0:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Sprite.stop()
	else:
		velocity.x = direction.x * SPEED * delta
		velocity.y = direction.y * SPEED * delta
		
		rotation = atan2(-velocity.x, velocity.y)
		$Sprite.play(current_animation)
		if not $StreamPlayer.playing:
			$StreamPlayer.play()
	
	move_and_slide()
	
func die():
	if dead:
		return
	$StreamPlayer.stream = load("res://sounds/wack.mp3")
	$StreamPlayer.play()
	$Sprite.play(current_animation+"_dead")
	dead = true
