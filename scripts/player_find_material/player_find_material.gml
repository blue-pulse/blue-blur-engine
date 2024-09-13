function player_find_material() {
	switch (collision_mode[0]) {
		// Floor
		case 0:
			return tile_find_material(pos_x, pos_y + 18, plane);
		// Right wall
		case 1:
			return tile_find_material(pos_x + 18, pos_y, plane);
		// Cealing
		case 2:
			return tile_find_material(pos_x, pos_y - 18, plane);
		// Left wall
		case 3:
			return tile_find_material(pos_x - 18, pos_y, plane);
	}
}
