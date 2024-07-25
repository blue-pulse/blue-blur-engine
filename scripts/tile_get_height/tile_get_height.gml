function tile_get_height(pos_x, tiledata, index) {
	if (tile_get_mirror(tiledata)) {
		var height_to_use = 16 - 1 - pos_x mod 16;
	} else {
		var height_to_use = pos_x mod 16;
	}
	
	// Return found height
	var tile = (index - 1) mod global.tile_data[1] + 1;
	return global.tile_heights[tile][height_to_use];
}
