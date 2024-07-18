function tile_check_material(pos_x, pos_y, tilelayer) {	
	pos_x = floor(pos_x);
	pos_y = floor(pos_y);
	
	// Get tile at position
	var plane  = global.tile_layers[tilelayer];
	var tile = tilemap_get(plane, pos_x div 16, pos_y div 16);
	var tile_index = tile_get_index(tile);
	var tile_material = tile_get_material(tile_index);

	// Return data
	return tile_material;
}