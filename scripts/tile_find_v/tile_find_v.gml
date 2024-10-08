function tile_find_v(pos_x, pos_y, to_positive, tilelayer) {
	// Normalize x and y
	pos_x = floor(pos_x);
	pos_y = floor(pos_y);

	if (to_positive and object_index != Player) {
		pos_x--;
		pos_y--;
	}

	// Exit if no tiledata found
	if (!array_length(global.tile_data)) {
		return [32, noone];
	}
	if (pos_x < 0 or pos_y < 0 or pos_x > room_width or pos_y > room_height) {
		return [32, noone];
	}

	var tile_dir = (to_positive) ? (1) : (-1);
	var tile_shift = 0;

	// Get tile at position
	var tile_lay = global.tile_layers[tilelayer];
	var tile = tilemap_get(tile_lay, pos_x div 16, pos_y div 16);
	var tile_index = tile_get_index(tile);
	var tile_height = tile_get_height(pos_x, tile, tile_index);

	// If no height found, get a tile away from the player
	if (!tile_height or tile_ignore_v(tile_index, to_positive)) {
		tile_shift = 16;
		tile = tilemap_get(tile_lay, pos_x div 16, (pos_y + tile_shift * tile_dir) div 16);
		tile_index = tile_get_index(tile);
		tile_height = tile_get_height(pos_x, tile, tile_index);
	}

	// If height found is 16px, try to find a tile closer to the player
	else if (tile_height == 16) {
		tile_shift = -16;
		tile = tilemap_get(tile_lay, pos_x div 16, (pos_y + tile_shift * tile_dir) div 16);
		tile_index = tile_get_index(tile);
		tile_height = tile_get_height(pos_x, tile, tile_index);

		// If no height found, revert back to the previous tile	
		if (!tile_height or tile_ignore_v(tile_index, to_positive)) {
			tile_shift = 0;
			tile = tilemap_get(tile_lay, pos_x div 16, pos_y div 16);
			tile_index = tile_get_index(tile);
			tile_height = tile_get_height(pos_x, tile, tile_index);
		}
	}

	// If final tile is top solid and we're checking upwards or outside the room, ignore it!
	if (tile_ignore_v(tile_index, to_positive) or(pos_y + tile_shift * tile_dir) & -16 >= room_height) {
		return [32, noone];
	}

	// Calculate distance to edge of the found tile
	if (to_positive) {
		var tile_dist = ((pos_y + tile_shift * tile_dir) & -16) + (16 - tile_height - 1) - pos_y;
	} else {
		var tile_dist = pos_y - (((pos_y + tile_shift * tile_dir) & -16) + tile_height);
	}


	// Get angle
	var tile_ang = tile_get_angle(tile_index);
	if (tile_ang != 360) {
		if (tile_get_flip(tile)) {
			tile_ang = (540 - tile_ang) mod 360;
		}
		if (tile_get_mirror(tile)) {
			tile_ang = 360 - tile_ang;
		}
	} else {
		tile_ang = (to_positive) ? (360) : (180);
	}

	// Return data
	return [tile_dist, tile_ang];
}
