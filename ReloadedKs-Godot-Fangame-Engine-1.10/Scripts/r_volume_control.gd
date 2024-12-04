extends Control

@onready var master_slider: HSlider = $VBoxContainer/MasterData/MasterSlider
@onready var bgm_slider: HSlider = $VBoxContainer/BGMData/BGMSlider
@onready var sfx_slider: HSlider = $VBoxContainer/SFXData/SFXSlider

@onready var master_value_info: Label = $VBoxContainer/MasterData/ValueInfo
@onready var bgm_value_info: Label = $VBoxContainer/BGMData/ValueInfo
@onready var sfx_value_info: Label = $VBoxContainer/SFXData/ValueInfo

@onready var music_play: AudioStreamPlayer = $MusicPlay
@onready var music_playing_text: Label = $MusicPlayingText

var master_bus = null
var music_bus = null
var sound_bus = null

var is_transitioning : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master_bus = AudioServer.get_bus_index("Master")
	music_bus = AudioServer.get_bus_index("Music")
	sound_bus = AudioServer.get_bus_index("Sounds")
	
	master_slider.grab_focus()
	
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus)) * 100
	bgm_slider.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus)) * 100
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(sound_bus)) * 100
	
	master_value_info.text = str(ceil(master_slider.value)) + "%"
	bgm_value_info.text = str(ceil(bgm_slider.value)) + "%"
	sfx_value_info.text = str(ceil(sfx_slider.value)) + "%"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("button_proceed_check") and !is_transitioning:
		ScreenTransition.change_room("res://Rooms/00_Title_and_menus/rTitle.tscn")
		is_transitioning = true

func _on_master_slider_value_changed(value: float) -> void:
	master_value_info.text = str(value) + "%"
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(value / 100))


func _on_bgm_slider_value_changed(value: float) -> void:
	bgm_value_info.text = str(value) + "%"
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value / 100))


func _on_sfx_slider_value_changed(value: float) -> void:
	sfx_value_info.text = str(value) + "%"
	AudioServer.set_bus_volume_db(sound_bus, linear_to_db(value / 100))


func _on_sound_button_pressed() -> void:
	GLOBAL_SOUNDS.play_sound(GLOBAL_SOUNDS.sndShoot)



func _on_music_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		music_play.play()
		music_playing_text.visible = true
	else:
		music_play.stop()
		music_playing_text.visible = false
