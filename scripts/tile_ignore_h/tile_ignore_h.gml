function tile_ignore_h(index, to_positive) {
	// Check for LBR Tiles
	if (index > global.tile_data[1] * 2) {
		if (object_index == Player) {
			if (!Player.is_grounded or !Player.collision_mode[0]) {
				return false;
			} else {
				return true;
			}
		} else {
			return false;
		}
	}

	// Check for Top Solid Tiles
	else if (index > global.tile_data[1]) {
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
	}

	// Do not ignore Full Solid Tiles
	else {
		return false;
	}
}
