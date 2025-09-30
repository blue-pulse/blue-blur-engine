function player_can_lock_on(object) {
	// Variables
	var player_x = floor(x);
	var player_y = floor(y);
	var object_x = floor(object.x);
	var object_y = floor(object.y);
	
	// Exit if the instance is far away
	if (point_distance(player_x, player_y, object_x, object_y) > 128) {
		return false;
	}
	
	// Exit on an indirect line of sight
	with (object) {
		if (collision_line(object_x, object_y, player_x, player_y, obj_solid, false, true)) {
			return false;
		}
	}
	
	// Check against rotation
	switch (mask_direction) {
		case 0:
			if (sign(object_x - player_x) != image_xscale or player_y >= object_y) {
				return false;
			}
			break;
			
		case 90:
			if (sign(player_y - object_y) != image_xscale or player_x >= object_x) {
				return false;
			}
			break;

		case 180:
			if (sign(player_x - object_x) != image_xscale or player_y <= object_y) {
				return false;
			}
			break;
		
		case 270:
			if (sign(object_y - player_y) != image_xscale or player_x <= object_x) {
				return false;
			}
			break;
	}
	
	// Lock-on is possible
	return true;
}
