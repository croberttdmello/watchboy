extends KinematicBody2D

var velocity = Vector2(0,0)
var coins  = 0
const SPEED = 300
const GRAVITY = 25
const JUMP_FORCE = -900

# Loop principal do jogo.
func _physics_process(delta):
	if Input.is_action_pressed("move_right"): 
		velocity.x = SPEED
		# Aplicando animação
		$Sprite.play("walking")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("move_left"): 
		velocity.x = -SPEED
		$Sprite.play("walking")
		# Virando o personagem para a esquerda 
		$Sprite.flip_h = true
	else:
		$Sprite.play("idle")
	if not is_on_floor():
		$Sprite.play("jumping")
	
	# Incrementando a velocidade de queda, gerando o efeito da gravidade.
	velocity.y += GRAVITY
	
	# Responsável por dar movimento ao player,
	# move_and_slide também retorna a velocidade atual
	# do player, logo quando ele colide com o chão, a 
	# velocidade vertical passa a ser zero. "Vector2.UP" 
	# diz qual em qual direção o vetor da face superior 
	# do chão aponta.
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE
	
	# A função "lerp" faz a transição entre dois valores de maneira moderada,
	# através de interpolação linear. Nesse caso, do valor atual para zero com 
	# um peso de 20%. Quanto maior a porcentagem maior o tempo da transição. 
	velocity.x = lerp(velocity.x, 0, 0.2)
	
	if coins == 5:
		get_tree().change_scene("res://Level1.tscn")
		
# Reinicia o jogo para a cena "Level1" quando o personangem cai. 
func _on_Fallzone_body_entered(body):
	get_tree().change_scene("res://Level1.tscn")
	
func add_coin():
	coins += 1
	
