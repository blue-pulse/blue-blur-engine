function tile_ignore_h(tile_index, to_positive) {
	// Check for LBR Tiles
	if (tile_index > global.tile_data[1] * 2) {
		if (object_index == Player) {
			if (!Player.is_grounded or !Player.collision_mode[0]) {
				return false;
			} else {
				return true;
			}
		} else {
			return false;
		}
	} else if tile_index > global.tile_data[1] {
		// Check for Top Solid Tiles
		if (object_index == Player) {
			if (!Player.is_grounded) {
				return true;
			} else {
				switch (Player.collision_mode[0]) {
					case 0:
						return true;
						break;
					case 1:
						return !to_positive;
						break;
					case 2:
						return true;
						break;
					case 3:
						return to_positive;
						break;
				}
			}
		} else {
			return true;
		}
	} else {
		// Do not ignore Full Solid Tiles
		return false;
	}
}