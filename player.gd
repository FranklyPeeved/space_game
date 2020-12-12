extends Area2D

export var velocity = 0
export var turning = 4.0
export var health = 10

var Bullet = preload("res://player_bullet.tscn")
var score = 0

func _process(delta):
	if Input.is_action_pressed("turn_left"):
		rotation -= turning * delta
	if Input.is_action_pressed("turn_right"):
		rotation += turning * delta
	if Input.is_action_just_pressed("fire"):
		Bullet.instance().init(self, 4000)

	gamepad(delta)
	position += Vector2.RIGHT.rotated(rotation) * velocity * delta
	
var virtual_stick_direction = Vector2.ZERO

func gamepad(delta):
	var input = Vector2(Input.get_joy_axis(0, 0), Input.get_joy_axis(0, 1)) + virtual_stick_direction
	if input.length() > 0.2:
		var direction = input.angle()
		rotation = Util.rotate_toward(rotation, direction, turning * delta) 


func _on_player_area_entered(area):
	health -= 1
	get_node("../HUD/health").value = health
	if health <= 0:
		get_tree().reload_current_scene()
	$crash_sound.play()
	modulate = Color(1000, 0, 0, 1)
	yield(get_tree().create_timer(1.0), "timeout")
	modulate = Color(1, 1, 1, 1) 
