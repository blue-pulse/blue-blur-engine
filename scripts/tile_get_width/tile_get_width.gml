function tile_get_width(pos_y, tiledata, index) {
	if (tile_get_flip(tiledata)) {
		var width_to_use = 16 - 1 - pos_y mod 16;
	} else {
		var width_to_use = pos_y mod 16;
	}
	
	// Return found width
	var tile = (index - 1) mod global.tile_data[1] + 1;
	return global.tile_widths[tile][width_to_use];
}
