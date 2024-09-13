function tile_find_2h(pos_x_1, pos_y_1, pos_x_2, pos_y_2, to_positive, object_angle, tilelayer) {
	// Get tiles at positions
	var find_tile_1 = tile_find_h(pos_x_1, pos_y_1, to_positive, tilelayer);
	var find_tile_2 = tile_find_h(pos_x_2, pos_y_2, to_positive, tilelayer);

	// Use closest tile
	if (find_tile_1[0] <= find_tile_2[0]) {
		var res_dist = find_tile_1[0];
		var res_ang = find_tile_1[1];
	} else {
		var res_dist = find_tile_2[0];
		var res_ang = find_tile_2[1];
	}

	// If object angle is valid, reset to cardinal if difference > 45 degrees
	if (object_angle != noone) {
		var diff = abs(object_angle mod 180 - res_ang mod 180);
		if (diff > 45 and diff < 135) {
			res_ang = round(object_angle / 90) mod 4 * 90;
			if (!res_ang) {
				res_ang = 360;
			}
		}
	}

	// Return data
	return [res_dist, res_ang];
}
