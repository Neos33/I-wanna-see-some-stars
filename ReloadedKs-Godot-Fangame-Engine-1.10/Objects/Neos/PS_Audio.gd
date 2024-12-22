extends AudioStreamPlayer

var music = null

const CHARGE = [preload("res://Audio/Music/Neos/Charge1.ogg"),
preload("res://Audio/Music/Neos/Charge2.ogg"),
preload("res://Audio/Music/Neos/Charge3.ogg"),
preload("res://Audio/Music/Neos/Charge4.ogg"),
preload("res://Audio/Music/Neos/Charge5.ogg"),
preload("res://Audio/Music/Neos/Charge6.ogg"),
preload("res://Audio/Music/Neos/Charge7.ogg")]

func _ready() -> void:
	volume_db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	
func _process(delta: float) -> void:
	volume_db = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	
func play_music():
	stream = CHARGE[randi() % CHARGE.size()]
	play()

func stop_music():
	stop()
	GLOBAL_MUSIC.music_resume()
