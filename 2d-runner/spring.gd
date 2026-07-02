extends AnimatedSprite2D


func _on_spring_area_body_entered(body: Node2D) -> void:
	%Spring.play("Bounce")
