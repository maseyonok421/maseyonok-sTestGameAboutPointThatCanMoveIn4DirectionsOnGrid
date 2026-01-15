extends AudioStreamPlayer

@export var trackList: Array[AudioStream]
var curTrackIdx = -1

func playRandomTrack():
	var idx = randi()%trackList.size()
	if ( idx == curTrackIdx ): idx = (idx+1)%trackList.size()
	curTrackIdx = idx
	stream = trackList[idx]
	play()

func _ready() -> void:
	playRandomTrack()
	print(curTrackIdx)
	print("musManager Inicialization OK")

func _on_finished() -> void:
	print(curTrackIdx)
	playRandomTrack()
	print(curTrackIdx)
	print("Audio Finished")
