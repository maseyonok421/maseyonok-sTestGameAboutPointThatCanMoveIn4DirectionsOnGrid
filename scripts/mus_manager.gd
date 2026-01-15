extends AudioStreamPlayer

@export var trackList: Array[AudioStream]
#var curTrackIdx = -1
var curTrackIdx = 0

#func playRandomTrack():
	#var idx = randi()%trackList.size()
	#if ( idx == curTrackIdx ): idx = (idx+1)%trackList.size()
	#curTrackIdx = idx
	#stream = trackList[idx]
	#play()

func playNextTrack():
	stream = trackList[curTrackIdx]
	play()
	curTrackIdx = (curTrackIdx+1)%trackList.size()

func _ready() -> void:
	trackList.shuffle()
	#playRandomTrack()
	playNextTrack()
	#print(curTrackIdx)
	print("musManager Inicialization OK")

func _on_finished() -> void:
	#print(curTrackIdx)
	#playRandomTrack()
	playNextTrack()
	#print(curTrackIdx)
	print("Audio Finished")
