function player_hitbox_update() {
	if (state == states.crouching) {
		hitbox = [
			floor(pos_x - 8), floor(pos_y - 4),
			floor(pos_x + 8), floor(pos_y + 16)
		];
	} else {
		hitbox = [
			floor(pos_x - 8), floor(pos_y - radius_y + 3),
			floor(pos_x + 8), floor(pos_y + radius_y - 3)
		];
	}
}
