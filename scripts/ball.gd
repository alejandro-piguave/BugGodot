extends RigidBody2D
class_name Ball

enum BoundPosition { TOP, LEFT, BOTTOM, RIGHT }

var bound_value: int
var bound_position: BoundPosition

signal outOfReach
signal playerTouch

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match bound_position:
		BoundPosition.TOP:
			if position.y < bound_value: 
				outOfReach.emit()
		BoundPosition.LEFT:
			if position.x < bound_value: 
				outOfReach.emit()
		BoundPosition.BOTTOM:
			if position.y > bound_value: 
				outOfReach.emit()
		BoundPosition.RIGHT:
			if position.x > bound_value: 
				outOfReach.emit()

func _on_area_2d_body_entered(body):
	if body.name == "Bug":
		playerTouch.emit()
