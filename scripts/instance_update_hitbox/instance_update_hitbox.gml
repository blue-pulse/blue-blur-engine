function instance_update_hitbox() {
	hitbox = [
		floor(x - radius_x), floor(y - radius_y),
		floor(x + radius_x), floor(y + radius_y),
	];
}
