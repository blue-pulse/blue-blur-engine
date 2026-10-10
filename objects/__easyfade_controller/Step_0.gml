// Coming in
if (__start_fade) {
	__timer++;
	if (__timer >= __duration) {
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
	__timer--;
}

// Set alpha
__alpha = __timer / __duration;

// Set audio gain
if (__fade_audio) {
	audio_master_gain(__audio_gain * (1 - __alpha));
}

// Finish when it is clear again
if (!__start_fade and __timer <= 0) {
	instance_destroy();
}
