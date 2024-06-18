function tile_get_width(pos_y, tiledata, index) {
	var width_to_use = tile_get_flip(tiledata) ? (16 - 1 - pos_y mod 16) : (pos_y mod 16);
	var tile = (index - 1) mod global.tile_data[1] + 1;
	return global.tile_widths[tile][width_to_use];
}