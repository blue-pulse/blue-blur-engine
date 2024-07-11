function player_physics_hitbox() {
	if (state != states.crouching) {
		hitbox = [
			floor(pos_x - 8), floor(pos_y - radius_y + 3),
			floor(pos_x + 8), floor(pos_y + radius_y - 3)
		];
	} else {
		hitbox = [
			floor(pos_x - 8), floor(pos_y - 4),
			floor(pos_x + 8), floor(pos_y + 16)
		];
	}
}