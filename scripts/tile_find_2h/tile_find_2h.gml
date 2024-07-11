function tile_find_2h(pos_x_1, pos_y_1, pos_x_2, pos_y_2, to_positive, object_angle, tilelayer) {
	// Get tiles at positions
	var found_tile_1 = tile_find_h(pos_x_1, pos_y_1, to_positive, tilelayer);
	var found_tile_2 = tile_find_h(pos_x_2, pos_y_2, to_positive, tilelayer);
	
	// Use closest tile
	if (found_tile_1[0] <= found_tile_2[0]) {
		var result_distance = found_tile_1[0];
		var result_angle = found_tile_1[1];
	} else {
		var result_distance = found_tile_2[0];
		var result_angle = found_tile_2[1];
	}
	
	// If object angle is defined, reset angle to cardinal one if difference is greater than 45 degrees
	if (object_angle != noone) {
		var difference = abs(object_angle mod 180 - result_angle mod 180);		
		if (difference > 45 and difference < 135) {
			result_angle = round(object_angle / 90) mod 4 * 90;
			if (!result_angle) {
				result_angle = 360;
			}
		}
	}
	
	// Return data
	return [result_distance, result_angle];
}