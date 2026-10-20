extends Node

@export var mob_scene: PackedScene
var score1
var score2
var playerDeath = false
var player2Death = false

func _ready() -> void:
	pass

func game_over():
	$MobTimer.stop()
	$Music.stop()
	if(score1 >= score2):
		print("Game Over! \nGuanyador\nJugador 1 \nPuntuació: ", score1)
		$HUD.show_game_over("Game over!\nGuanyador\nJugador 1")
	else:
		print("Game Over! \nGuanyador\nJugador 2 \nPuntuació: ", score2)
		$HUD.show_game_over("Game over!\nGuanyador\nJugador 2")


func new_game():
	playerDeath = false
	player2Death = false
	score1 = 0
	score2 = 0
	$Player.start($StartPosition.position)
	$Player2.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score1)
	$HUD.update_score2(score2)
	$HUD.show_message("Get Ready")
	$Music.play()
	get_tree().call_group("mobs", "queue_free")


func _on_score_timer_timeout() -> void:
	score1 += 1
	$HUD.update_score(score1)

func _on_score_timer_2_timeout() -> void:
	score2 += 1
	$HUD.update_score2(score2)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	$ScoreTimer2.start()

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()

	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	var direction = mob_spawn_location.rotation + PI / 2
	mob.position = mob_spawn_location.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)

func _on_player_hit() -> void:
	hit_player1()

func _on_player_2_hit_2() -> void:
	hit_player2()

func hit_player1():
	$ScoreTimer.stop()
	$DeathSound.play()
	playerDeath = true
	if(player2Death == playerDeath):
		game_over()

func hit_player2():
	$ScoreTimer2.stop()
	$DeathSound.play()
	player2Death = true
	if(player2Death == playerDeath):
		game_over()
