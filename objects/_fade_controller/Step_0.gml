// Coming in
if (start_fade) {
	if (timer++ >= duration) {
		// Change flag
		start_fade = false;
		
		// Only change room if it exists
		if (target_room != noone) {
			room_goto(target_room);
		}
	}
}

// Coming out
else {
	if (!timer--) {
		instance_destroy();
	}
}

// Set alpha
alpha = timer / duration;
