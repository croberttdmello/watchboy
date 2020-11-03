extends Area2D

signal coin_collected

func _on_Coin_body_entered(body):
	$AnimationPlayer.play("Bouncing")
	emit_signal("coin_collected")
	
	# Usando collision mask para evitar que a mesma moeda seja coletada
	# duas vezes. 
	set_collision_mask_bit(0, false)
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
