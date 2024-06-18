function tile_find_v(pos_x, pos_y, to_positive, tile_layer) {
	// Prepare position data
	pos_x = floor(pos_x);
	pos_y = floor(pos_y);
	
	if (to_positive and (object_index != Player)) {
		pos_x--;
		pos_y--;
	}
	
	// Exit if no tiledata found
	if (!array_length(global.tile_data)) {
		return [32, noone];
	}
	
	if ((pos_x < 0) or (pos_y < 0) or (pos_x > room_width) or (pos_y > room_height)) {
		return [32, noone];
	}
	
	var tile_direction = to_positive ? 1 : -1;
	var shift = 0;
	
	// Get tile at position
	var current_layer = global.tile_layers[tile_layer];
	var current_tile = tilemap_get(current_layer, pos_x div 16, pos_y div 16);
	var tile_index = tile_get_index(current_tile);
	var tile_height = tile_get_height(pos_x, current_tile, tile_index);
	
	// If no height found, get a tile away from the player
	if (!tile_height or tile_ignore_v(tile_index, to_positive)) {
		shift = 16;
		current_tile = tilemap_get(current_layer, pos_x div 16, (pos_y + shift * tile_direction) div 16);
		tile_index = tile_get_index(current_tile);
		tile_height = tile_get_height(pos_x, current_tile, tile_index);
	} else if (tile_height == 16) {
		// Try to find a tile closer to the player
		shift = -16;
		current_tile = tilemap_get(current_layer, pos_x div 16, (pos_y + shift * tile_direction) div 16);
		tile_index = tile_get_index(current_tile);
		tile_height = tile_get_height(pos_x, current_tile, tile_index);
		
		// If no height found, revert back to the previous tile	
		if (!tile_height or tile_ignore_v(tile_index, to_positive)) {
			shift = 0;
			current_tile = tilemap_get(current_layer, pos_x div 16, pos_y div 16);
			tile_index = tile_get_index(current_tile);
			tile_height = tile_get_height(pos_x, current_tile, tile_index);
		}
	}
	
	// If final tile is top solid and we're checking upwards or outside the room, ignore it
	if (tile_ignore_v(tile_index, to_positive) or (pos_y + shift * tile_direction) & -16 >= room_height) {
		return [32, noone];
	}
	
	// Calculate distance to edge of the found tile
	var tile_distance = 0;
	if (to_positive) {
		tile_distance = ((pos_y + shift * tile_direction) & -16) + (16 - tile_height - 1) - pos_y;
	} else {
		tile_distance = pos_y - (((pos_y + shift * tile_direction) & -16) + tile_height);
	}

	// Get angle
	var tile_angle = tile_get_angle(tile_index);
	if (tile_angle != 360) {
		if (tile_get_flip(current_tile)) {
			tile_angle = (540 - tile_angle) mod 360;
		}
		
		if (tile_get_mirror(current_tile)) {
			tile_angle = 360 - tile_angle;
		}
	} else {
		tile_angle = to_positive ? 360 : 180;
	}
	
	// Return data
	return [tile_distance, tile_angle];
}