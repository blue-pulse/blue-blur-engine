function player_update_params() {
	// Handle invincibility timer
	if (invincibility_frames and !is_being_hurt) {
		invincibility_frames--;
	}
	
	// Grant extra life for collecting 100 rings
	if (rings mod 100 == 0) {
		player_increase_lives();
	}
}
