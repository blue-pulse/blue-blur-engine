function tile_ignore_v(index, to_positive) {
	// Check for LBR Tiles
	if (index > global.tile_data[1] * 2) {
		if (object_index == Player) {
			if (!Player.is_grounded or !Player.collision_mode[0]) {
				return to_positive;
			} else {
				return true;
			}
		} else {
			return to_positive;
		}
	}

	// Check for Top Solid Tiles
	else if (index > global.tile_data[1]) {
		if (object_index == Player) {
			if (!Player.is_grounded) {
				return !to_positive;
			} else {
				switch Player.collision_mode[0] {
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
	}

	// Do not ignore Full Solid Tiles
	else {
		return false;
	}
}
