extends Node2D

enum BallPosition{ TOP, LEFT, BOTTOM, RIGHT }

const ballScene = preload("res://scenes/ball.tscn")

const TILE_COUNT = 7
const TILE_SIZE = 32
const MAP_SIZE = TILE_SIZE * TILE_COUNT

const BALL_IMPULSE = 100

var currentBall: Ball

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_ball()

func spawn_ball():
	var ball = ballScene.instantiate()
	
	var ballPosition: BallPosition = randi() % BallPosition.size()
	var ballTile = randi_range(1, TILE_COUNT - 2)
	 
	match ballPosition:
		BallPosition.TOP:
			ball.position.x = TILE_SIZE * 0.5 + ballTile * TILE_SIZE
			ball.position.y = TILE_SIZE * 0.5
			ball.apply_impulse(Vector2(0, BALL_IMPULSE))
			ball.boundPosition = Ball.BoundPosition.BOTTOM
			ball.boundValue = MAP_SIZE
		BallPosition.LEFT:
			ball.position.y = TILE_SIZE * 0.5 + ballTile * TILE_SIZE
			ball.position.x = TILE_SIZE * 0.5
			ball.apply_impulse(Vector2(BALL_IMPULSE, 0))
			ball.boundPosition = Ball.BoundPosition.RIGHT
			ball.boundValue = MAP_SIZE
		BallPosition.BOTTOM:
			ball.position.x = TILE_SIZE * 0.5 + ballTile * TILE_SIZE
			ball.position.y = MAP_SIZE - TILE_SIZE * 0.5
			ball.apply_impulse(Vector2(0, -BALL_IMPULSE))
			ball.boundPosition = Ball.BoundPosition.TOP
			ball.boundValue = 0
		BallPosition.RIGHT:
			ball.position.y = TILE_SIZE * 0.5 + ballTile * TILE_SIZE
			ball.position.x = MAP_SIZE - TILE_SIZE * 0.5
			ball.apply_impulse(Vector2(-BALL_IMPULSE, 0))
			ball.boundPosition = Ball.BoundPosition.LEFT
			ball.boundValue = 0
	ball.outOfReach.connect(on_ball_out_of_reach)
	ball.playerTouch.connect(on_player_touch)
	add_child(ball)
	currentBall = ball
	

func on_ball_out_of_reach():
	currentBall.queue_free()
	spawn_ball()

func on_player_touch():
	$"../Bug".die()
