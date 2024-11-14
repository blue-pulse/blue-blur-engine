function instance_check_collision(src_hitbox, dest_hitbox) {
	return rectangle_in_rectangle(
		src_hitbox[0], src_hitbox[1], src_hitbox[2], src_hitbox[3],
		dest_hitbox[0], dest_hitbox[1], dest_hitbox[2], dest_hitbox[3]
	);
}
