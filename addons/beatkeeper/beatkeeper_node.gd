tool
extends AudioStreamPlayer

export var Tempo : float = 100 # BPM
export var Offset_in_MS : int = 0 # Milliseconds
export var PlayDelay_MS : int = 0 # Milliseconds

# Physics process with high forced physics fps may result in more stability
enum ProcessEnum {PROCESS, PHYSICS_PROCESS}
export(ProcessEnum) var processing_mode = ProcessEnum.PROCESS

# Emits alt signals so audio can start earlier than the beat actually happens
# Example: AudioStreamPlayer.play() on an audio signal emitted would start playing at the correct time
export var audio_mode : bool = false 

# Whether to emit these beats
export var whole_beats : bool = true
export var half_beats : bool = false
export var third_beats : bool = false
export var quarter_beats : bool = false
export var fifth_beats : bool = false
export var sixth_beats : bool = false
export var seventh_beats : bool = false
export var eighth_beats : bool = false
export var ninth_beats : bool = false
export var twelfth_beats : bool = false
export var sixteenth_beats : bool = false


signal whole_beat(number, exact_msec) # 1 beat
signal half_beat(number, exact_msec) # 1/2 beat
signal third_beat(number, exact_msec) # 1/3 beat
signal quarter_beat(number, exact_msec) # 1/4 beat
signal fifth_beat(number, exact_msec) # 1/5 beat
signal sixth_beat(number, exact_msec) # 1/6 beat
signal seventh_beat(number, exact_msec) # 1/7 beat
signal eighth_beat(number, exact_msec) # 1/8 beat
signal ninth_beat(number, exact_msec) # 1/9 beat
signal twelfth_beat(number, exact_msec) # 1/12 beat
signal sixteenth_beat(number, exact_msec) # 1/16 beat

signal whole_beat_audio(number, exact_msec) # 1 beat_audio
signal half_beat_audio(number, exact_msec) # 1/2 beat_audio
signal third_beat_audio(number, exact_msec) # 1/3 beat_audio
signal quarter_beat_audio(number, exact_msec) # 1/4 beat_audio
signal fifth_beat_audio(number, exact_msec) # 1/5 beat_audio
signal sixth_beat_audio(number, exact_msec) # 1/6 beat_audio
signal seventh_beat_audio(number, exact_msec) # 1/7 beat_audio
signal eighth_beat_audio(number, exact_msec) # 1/8 beat_audio
signal ninth_beat_audio(number, exact_msec) # 1/9 beat_audio
signal twelfth_beat_audio(number, exact_msec) # 1/12 beat_audio
signal sixteenth_beat_audio(number, exact_msec) # 1/16 beat_audio


var time_begin

var real_playing = false

func play(default : float = 0):
	time_begin = OS.get_ticks_usec()
	time_begin += Offset_in_MS * 1000
	time_begin += (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()) * 1000000
	real_playing = true
	yield(get_tree().create_timer(PlayDelay_MS/1000.0), "timeout")
	.play(default)

var count_whole_beat : int = 0
var count_half_beat : int = 0
var count_third_beat : int = 0
var count_quarter_beat : int = 0
var count_fifth_beat : int = 0
var count_sixth_beat : int = 0
var count_seventh_beat : int = 0
var count_eighth_beat : int = 0
var count_ninth_beat : int = 0
var count_twelfth_beat : int = 0
var count_sixteenth_beat : int = 0

var audio_count_whole_beat : int = 0
var audio_count_half_beat : int = 0
var audio_count_third_beat : int = 0
var audio_count_quarter_beat : int = 0
var audio_count_fifth_beat : int = 0
var audio_count_sixth_beat : int = 0
var audio_count_seventh_beat : int = 0
var audio_count_eighth_beat : int = 0
var audio_count_ninth_beat : int = 0
var audio_count_twelfth_beat : int = 0
var audio_count_sixteenth_beat : int = 0


func _process(_delta):
	if processing_mode == ProcessEnum.PROCESS: run_process()

func _physics_process(_delta):
	if processing_mode == ProcessEnum.PHYSICS_PROCESS: run_process()

func begin_ms():
	return time_begin / 1000.0

func cur_ms():
	return OS.get_ticks_msec() - begin_ms()



func run_process():
	if !real_playing: return
	
	var ms_between_beats = 60000.0 / Tempo
	var audio_delay = (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()) * 1000
	
	if cur_ms() >= audio_count_whole_beat * ms_between_beats - audio_delay:
		audio_count_whole_beat += 1
		if whole_beats and audio_mode:
			emit_signal("whole_beat_audio", audio_count_whole_beat, (audio_count_whole_beat-1) * ms_between_beats - audio_delay + begin_ms())
	
	if cur_ms() >= audio_count_half_beat * (ms_between_beats/2.0) - audio_delay:
		audio_count_half_beat += 1
		if half_beats and audio_mode:
			emit_signal("half_beat_audio", audio_count_half_beat, (audio_count_half_beat-1) * (ms_between_beats/2.0) - audio_delay + begin_ms())
	
	if cur_ms() >= audio_count_third_beat * (ms_between_beats/3.0) - audio_delay:
		audio_count_third_beat += 1
		if third_beats and audio_mode:
			emit_signal("third_beat_audio", audio_count_third_beat, (audio_count_third_beat-1) * (ms_between_beats/3.0) - audio_delay + begin_ms())
	
	if cur_ms() >= audio_count_quarter_beat * (ms_between_beats/4.0) - audio_delay:
		audio_count_quarter_beat += 1
		if quarter_beats and audio_mode:
			emit_signal("quarter_beat_audio", audio_count_quarter_beat, (audio_count_quarter_beat-1) * (ms_between_beats/4.0) - audio_delay + begin_ms())
	
	if cur_ms() >= audio_count_fifth_beat * (ms_between_beats/5.0) - audio_delay:
		audio_count_fifth_beat += 1
		if fifth_beats and audio_mode:
			emit_signal("fifth_beat_audio", audio_count_fifth_beat, (audio_count_fifth_beat-1) * (ms_between_beats/5.0) - audio_delay + begin_ms())
	
	if cur_ms() >= audio_count_sixth_beat * (ms_between_beats/6.0) - audio_delay:
		audio_count_sixth_beat += 1
		if sixth_beats and audio_mode:
			emit_signal("sixth_beat_audio", audio_count_sixth_beat, (audio_count_sixth_beat-1) * (ms_between_beats/6.0) - audio_delay + begin_ms())
	
	if cur_ms() >= audio_count_seventh_beat * (ms_between_beats/7.0) - audio_delay:
		audio_count_seventh_beat += 1
		if seventh_beats and audio_mode:
			emit_signal("seventh_beat_audio", audio_count_seventh_beat, (audio_count_seventh_beat-1) * (ms_between_beats/7.0) - audio_delay + begin_ms())
	
	if cur_ms() >= audio_count_eighth_beat * (ms_between_beats/8.0) - audio_delay:
		audio_count_eighth_beat += 1
		if eighth_beats and audio_mode:
			emit_signal("eighth_beat_audio", audio_count_eighth_beat, (audio_count_eighth_beat-1) * (ms_between_beats/8.0) - audio_delay + begin_ms())
	
	if cur_ms() >= audio_count_ninth_beat * (ms_between_beats/9.0) - audio_delay:
		audio_count_ninth_beat += 1
		if ninth_beats and audio_mode:
			emit_signal("ninth_beat_audio", audio_count_ninth_beat, (audio_count_ninth_beat-1) * (ms_between_beats/9.0) - audio_delay + begin_ms())
	
	if cur_ms() >= audio_count_twelfth_beat * (ms_between_beats/12.0) - audio_delay:
		audio_count_twelfth_beat += 1
		if twelfth_beats and audio_mode:
			emit_signal("twelfth_beat_audio", audio_count_twelfth_beat, (audio_count_twelfth_beat-1) * (ms_between_beats/12.0) - audio_delay + begin_ms())
	
	if cur_ms() >= audio_count_sixteenth_beat * (ms_between_beats/16.0) - audio_delay:
		audio_count_sixteenth_beat += 1
		if sixteenth_beats and audio_mode:
			emit_signal("sixteenth_beat_audio", audio_count_sixteenth_beat, (audio_count_sixteenth_beat-1) * (ms_between_beats/16.0) - audio_delay + begin_ms())
	
	if cur_ms() >= count_whole_beat * ms_between_beats:
		count_whole_beat += 1
		if whole_beats:
			emit_signal("whole_beat", count_whole_beat, (count_whole_beat-1) * ms_between_beats + begin_ms())
	
	if cur_ms() >= count_half_beat * (ms_between_beats/2.0):
		count_half_beat += 1
		if half_beats:
			emit_signal("half_beat", count_half_beat, (count_half_beat-1) * (ms_between_beats/2.0) + begin_ms())
	
	if cur_ms() >= count_third_beat * (ms_between_beats/3.0):
		count_third_beat += 1
		if third_beats:
			emit_signal("third_beat", count_third_beat, (count_third_beat-1) * (ms_between_beats/3.0) + begin_ms())
	
	if cur_ms() >= count_quarter_beat * (ms_between_beats/4.0):
		count_quarter_beat += 1
		if quarter_beats:
			emit_signal("quarter_beat", count_quarter_beat, (count_quarter_beat-1) * (ms_between_beats/4.0 )+ begin_ms())
	
	if cur_ms() >= count_fifth_beat * (ms_between_beats/5.0):
		count_fifth_beat += 1
		if fifth_beats:
			emit_signal("fifth_beat", count_fifth_beat, (count_fifth_beat-1) * (ms_between_beats/5.0) + begin_ms())
	
	if cur_ms() >= count_sixth_beat * (ms_between_beats/6.0):
		count_sixth_beat += 1
		if sixth_beats:
			emit_signal("sixth_beat", count_sixth_beat, (count_sixth_beat-1) * (ms_between_beats/6.0) + begin_ms())
	
	if cur_ms() >= count_seventh_beat * (ms_between_beats/7.0):
		count_seventh_beat += 1
		if seventh_beats:
			emit_signal("seventh_beat", count_seventh_beat, (count_seventh_beat-1) * (ms_between_beats/7.0) + begin_ms())
	
	if cur_ms() >= count_eighth_beat * (ms_between_beats/8.0):
		count_eighth_beat += 1
		if eighth_beats:
			emit_signal("eighth_beat", count_eighth_beat, (count_eighth_beat-1) * (ms_between_beats/8.0) + begin_ms())
	
	if cur_ms() >= count_ninth_beat * (ms_between_beats/9.0):
		count_ninth_beat += 1
		if ninth_beats:
			emit_signal("ninth_beat", count_ninth_beat, (count_ninth_beat-1) * (ms_between_beats/9.0) + begin_ms())
	
	if cur_ms() >= count_twelfth_beat * (ms_between_beats/12.0):
		count_twelfth_beat += 1
		if twelfth_beats:
			emit_signal("twelfth_beat", count_twelfth_beat, (count_twelfth_beat-1) * (ms_between_beats/12.0) + begin_ms())
	
	if cur_ms() >= count_sixteenth_beat * (ms_between_beats/16.0):
		count_sixteenth_beat += 1
		if sixteenth_beats:
			emit_signal("sixteenth_beat", count_sixteenth_beat, (count_sixteenth_beat-1) * (ms_between_beats/16.0) + begin_ms())







