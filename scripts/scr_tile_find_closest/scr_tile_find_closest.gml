function tile_find_closest(x_1, y_1, x_2, y_2, to_positive, object_angle, tile_layer, analysis_type) {
	// Get tiles at positions
	var first_tile = analysis_type(x_1, y_1, to_positive, tile_layer);
	var second_tile = analysis_type(x_2, y_2, to_positive, tile_layer);

	// Use closest tile
	if (first_tile[0] <= second_tile[0]) {
		var distance_to_tile = first_tile[0];
		var tile_angle = first_tile[1];
	} else {
		var distance_to_tile = second_tile[0];
		var tile_angle = second_tile[1];
	}
	
	// If object angle is defined, reset angle to cardinal one if difference is greater than 45 degrees
	if (object_angle != noone) {
		var difference = abs(object_angle mod 180 - tile_angle mod 180);		
		if ((difference > 45) and (difference < 135)) {
			tile_angle = round(object_angle / 90) mod 4 * 90;
			if (!tile_angle) {
				tile_angle = 360;
			}
		}
	}
	
	// Return data
	return [distance_to_tile, tile_angle];
}