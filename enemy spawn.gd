extends Timer

export (PackedScene) var  Enemy
export var MAX_ENEMIES = 10
export var MAX_SCORE = 999999
export var MIN_SCORE = 0
onready var player = get_node("/root/main/player")
var number_spawn = 0
export var NUMBERTOSPAWN = 999999



func _on_enemy_spawn_timeout():
	if get_child_count() < MAX_ENEMIES && player.score <= MAX_SCORE \
	&& player.score >= MIN_SCORE && number_spawn < NUMBERTOSPAWN:
		var enemy = Enemy.instance()
		add_child(enemy)
		enemy.spawn()
		number_spawn += 1
