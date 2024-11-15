function player_update_hitbox() {
	if (state == states.crouching or state == states.sliding) {
		hitbox = [
			floor(pos_x - 8), floor(pos_y - 4),
			floor(pos_x + 8), floor(pos_y + 16),
		];
	} else {
		hitbox = [
			floor(pos_x - 8), floor(pos_y - radius_y + 3),
			floor(pos_x + 8), floor(pos_y + radius_y - 3),
		];
	}
}
