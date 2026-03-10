// Early exit
if (!usable or is_fading or !instance_exists(player)) {
	exit;
}

// Activate level selector
if (active) {
	// Set checkpoint data
	if (allow_transition) {
		global.checkpoint.set_hub(x, y);
		room_fadeto(stage, 60, c_black, true);
	}
	
	// Lock player
	else {
		if (distance_to_object(player) < 100) {	
			camera_set_target(self);
			with (player) {
				if (state == player_state_lookup) {
					player_set_state(player_state_lock);
					other.allow_transition = true;
				}
			}
		} else {
			camera_set_target(player);
		}
	}
}
