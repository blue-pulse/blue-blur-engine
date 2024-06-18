function tile_ignore_v(tile_index, to_positive) {
	// Check for LBR Tiles
	if (tile_index > global.tile_data[1] * 2) {
		if (object_index == Player) {
			if (!Player.is_grounded or !Player.collision_mode[0]) {
				return to_positive;
			} else {
				return true;
			}
		} else {
			return to_positive;
		}
	} else if (tile_index > global.tile_data[1]) {
		// Check for Top Solid Tiles
		if (object_index == Player) {
			if (!Player.is_grounded) {
				return !to_positive;
			} else {
				switch (Player.collision_mode[0]) {
					case 0:
						return !to_positive;
						break;
					case 1:
						return true;
						break;
					case 2:
						return to_positive;
						break;
					case 3:
						return true;
						break;
				}
			}
		} else {
			return !to_positive;
		}
	} else {
		// Do not ignore Full Solid Tiles
		return false;
	}
}