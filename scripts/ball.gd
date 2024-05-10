extends RigidBody2D
class_name Ball

enum BoundPosition { TOP, LEFT, BOTTOM, RIGHT }

var bound_value: int
var bound_position: BoundPosition

signal out_of_reach
signal player_touch

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match bound_position:
		BoundPosition.TOP:
			if position.y < bound_value: 
				out_of_reach.emit()
		BoundPosition.LEFT:
			if position.x < bound_value: 
				out_of_reach.emit()
		BoundPosition.BOTTOM:
			if position.y > bound_value: 
				out_of_reach.emit()
		BoundPosition.RIGHT:
			if position.x > bound_value: 
				out_of_reach.emit()

func _on_area_2d_body_entered(body):
	if body.name == "Bug":
		player_touch.emit()
