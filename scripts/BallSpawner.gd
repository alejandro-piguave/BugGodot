extends Node2D

enum BallPosition { TOP, LEFT, BOTTOM, RIGHT }

const ballScene = preload("res://scenes/ball.tscn")

const TILE_COUNT = 7
const TILE_SIZE = 32
const MAP_SIZE = TILE_SIZE * TILE_COUNT

const BALL_IMPULSE = 100

const ball_amount: int = 2
var detected_balls: int = 0
var current_balls: Array[Ball]

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_balls()

func create_ball():
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
	
	return ball
	
	
func spawn_balls():
	for i in ball_amount:
		var ball = create_ball()
		add_child(ball)
		current_balls.append(ball)
	detected_balls = 0
func on_ball_out_of_reach():
	detected_balls += 1
	
	if detected_balls == ball_amount and not $"../Bug".dead:
		score += 1
		$"../ScoreLabel".text = str(score)
		for i in ball_amount:
			current_balls[i].queue_free()
		current_balls.clear()
		spawn_balls()
	elif $"../Bug".dead:
		$"../ScoreSaver".save_score(score)
		get_tree().change_scene_to_file("res://scenes/score.tscn")
	
func on_player_touch():
	$"../Bug".die()
