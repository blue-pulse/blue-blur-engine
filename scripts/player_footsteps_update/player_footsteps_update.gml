function player_footsteps_update() {
	// Variables
	var material = materials.generic;
	var dist_to_tile = 18;
	
	// See tile information based on current collision mode
	switch collision_mode[0] {
		// FLoor
		case 0:
			material = tile_check_material(pos_x, pos_y + dist_to_tile, plane);
			break;
		// Right wall
		case 1:
			material = tile_check_material(pos_x + dist_to_tile, pos_y, plane);
			break;
		// Cealing
		case 2:
			material = tile_check_material(pos_x, pos_y - dist_to_tile, plane);
			break;
		// Left wall
		case 3:
			material = tile_check_material(pos_x - dist_to_tile, pos_y, plane);
			break;
	}
}