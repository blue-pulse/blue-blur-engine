function point_in_hitbox(pos_x, pos_y, dest_hitbox) {
	return point_in_rectangle(
		pos_x, pos_y,
		dest_hitbox[0], dest_hitbox[1], dest_hitbox[2], dest_hitbox[3]
	);
}
