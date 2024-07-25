
function tile_find_h(pox_x, pox_y, to_positive, tilelayer) {	
	pox_x = floor(pox_x);
	pox_y = floor(pox_y);
	
	if (to_positive and object_index != Player) {
		pox_x--;
		pox_y--;
	}

	// Exit if no tiledata found
	if (!array_length(global.tile_data)) {
		return [32, noone];
	}
	
	if (pox_x < 0 or pox_y < 0 or pox_x > room_width or pox_y > room_height) {
		return [32, noone];
	}
	
	var tile_direction = to_positive ? 1 : -1;
	var tile_shift = 0;
	
	// Get tile at position
	var plane  = global.tile_layers[tilelayer];
	var tile = tilemap_get(plane, pox_x div 16, pox_y div 16);
	var tile_index = tile_get_index(tile);
	var tile_width = tile_get_width(pox_y, tile, tile_index);
	
	// If no width found, get a tile away from the player
	if (!tile_width or tile_ignore_h(tile_index, to_positive)) {
		tile_shift = 16;
		tile = tilemap_get(plane, (pox_x + tile_shift * tile_direction) div 16, pox_y div 16);
		tile_index = tile_get_index(tile);
		tile_width = tile_get_width(pox_y, tile, tile_index);
	} else if (tile_width == 16) {
		// If width found is 16px, try to find a tile closer to the player
		tile_shift = -16;
		tile = tilemap_get(plane, (pox_x + tile_shift * tile_direction) div 16, pox_y div 16);
		tile_index = tile_get_index(tile);
		tile_width = tile_get_width(pox_y, tile, tile_index);

		// If no width found, revert back to the previous tile	
		if (!tile_width or tile_ignore_h(tile_index, to_positive)) {
			tile_shift = 0;
			tile = tilemap_get(plane, pox_x div 16, pox_y div 16);
			tile_index = tile_get_index(tile);
			tile_width = tile_get_width(pox_y, tile, tile_index);
		}
	}
	
	// If final tile is top solid, ignore it!
	if (tile_ignore_h(tile_index, to_positive)) {
		return [32, noone];
	}
	
	// Calculate distance to edge of the found tile
	if (to_positive) {
		var tile_distance = ((pox_x + tile_shift * tile_direction) & -16) + (16 - tile_width - 1) - pox_x;
	} else {
		var tile_distance = pox_x - (((pox_x + tile_shift * tile_direction) & -16) + tile_width);
	}
	
	// Get angle
	var tile_angle = tile_get_angle(tile_index);
	if (tile_angle != 360) {
		if (tile_get_flip(tile)) {
			tile_angle = (540 - tile_angle) mod 360;
		}
		
		if (tile_get_mirror(tile)) {
			tile_angle = 360 - tile_angle;
		}
	} else {
		tile_angle = to_positive ? 90 : 270;
	}
	
	// Return data
	return [tile_distance, tile_angle];
}
