extends RigidBody2D
class_name Ball

enum BoundPosition { TOP, LEFT, BOTTOM, RIGHT }

var boundValue: int
var boundPosition: BoundPosition

signal outOfReach

signal playerTouch

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match boundPosition:
		BoundPosition.TOP:
			if position.y < boundValue: 
				outOfReach.emit()
		BoundPosition.LEFT:
			if position.x < boundValue: 
				outOfReach.emit()
		BoundPosition.BOTTOM:
			if position.y > boundValue: 
				outOfReach.emit()
		BoundPosition.RIGHT:
			if position.x > boundValue: 
				outOfReach.emit()



func _on_body_entered(body):
	if body.name == "Bug":
		print("player touched")
