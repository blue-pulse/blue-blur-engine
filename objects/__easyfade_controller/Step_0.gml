// Coming in
if (__start_fade) {
	if (__timer++ >= __duration) {
		// Change flag
		__start_fade = false;

		// Only change room if there is one
		if (__target_room != noone) {
			room_goto(__target_room);
		}
	}
}

// Coming out
else {
	if (!__timer--) {
		instance_destroy();
	}
}

// Set alpha
__alpha = __timer / __duration;

// Set audio gain
if (__fade_audio) {
	audio_master_gain(__audio_gain * (1 - __alpha));
}
