function tile_get_angle(index) {
	var tile = (index - 1) mod global.tile_data[1] + 1;
	if (tile) then return global.tile_angles[tile];
	return noone;
}