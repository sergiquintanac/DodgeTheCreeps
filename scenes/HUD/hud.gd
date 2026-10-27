extends CanvasLayer

signal start_game
signal start_game_local

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over(text):
	show_message(text)
	# Espereu fins que el MessageTimer hagi acabat de comptar.
	await $MessageTimer.timeout
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	# Feu un temporitzador one-shot i espereu que acabi.
	await get_tree().create_timer(1).timeout
	$StartButton.show()
	$MultiButton.show()
	$OnlineButton.show()
	$SettingsButton.show()
	$HighscoresButton.show()
	$AboutButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func update_score2(score):
	$ScoreLabel2.text = str(score)

func _on_message_timer_timeout() -> void:
	$Message.hide()

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$MultiButton.hide()
	$OnlineButton.hide()
	$SettingsButton.hide()
	$HighscoresButton.hide()
	$AboutButton.hide()
	emit_signal("start_game")

func _on_multi_button_pressed() -> void:
	$StartButton.hide()
	$MultiButton.hide()
	$OnlineButton.hide()
	$SettingsButton.hide()
	$HighscoresButton.hide()
	$AboutButton.hide()
	emit_signal("start_game_local")
