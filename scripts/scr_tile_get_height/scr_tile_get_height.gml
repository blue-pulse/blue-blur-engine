function tile_get_height(pos_x, tiledata, index) {
	var height_to_use = tile_get_mirror(tiledata) ? (16 - 1 - pos_x mod 16) : (pos_x mod 16);
	var tile = (index - 1) mod global.tile_data[1] + 1;
	return global.tile_heights[tile][height_to_use];
}