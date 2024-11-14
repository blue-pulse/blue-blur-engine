function instance_set_hitbox(width, height) {
	radius_x = width;
	radius_y = height;
	hitbox = [
		floor(x - width), floor(y - height),
		floor(x + width), floor(y + height),
	];
}
