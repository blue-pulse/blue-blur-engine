function tile_check(pos_x, pos_y, no_top_solid, tilelayer) {
	pos_x = floor(pos_x);
	pos_y = floor(pos_y);
	
	// Exit if no tiledata found
	if (!array_length(global.tile_data)) {
		return false;
	}
	
    if (pos_x <= 0 or pos_y <= 0 or pos_x >= room_width or pos_y >= room_height) {
        return false;
    }
	
	// Get tile at position
	var plane = global.tile_layers[tilelayer];
    var tile = tilemap_get(plane, pos_x div 16, pos_y div 16);
    var tile_index = tile_get_index(tile);
	
   	// Exit if tile is top-only and we're ignoring them
    if (no_top_solid and tile_index > global.tile_data[1]) {
        return false;
    }
	
	// Return check result
	if (tile_get_flip(tile)) {
		return pos_y mod 16 < tile_get_height(pos_x, tile, tile_index);
	} else {
		return 16 - 1 - pos_y mod 16 < tile_get_height(pos_x, tile, tile_index);
	}
}
