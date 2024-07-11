function tile_get_angle(index) {
	// Return found angle
	var tile = (index - 1) mod global.tile_data[1] + 1;
	if (tile) {
		return global.tile_angles[tile];
	}
	
	// If no tile found, return empty angle
	return noone;
}