// Inherit the parent event
event_inherited();

// Main logic
switch (state) {
	case states.fall:
		// Fall to the ground
		pos_x += hor_speed;
		pos_y += ver_speed;
		ver_speed += 0.21875;

		// Check for floor
		var find_floor = tile_find_v(pos_x, pos_y + 15, true, plane)[0];
		if (find_floor < 0) {
			// Parameters
			pos_y += find_floor;
			state = states.move;
			timer = 16;
			
			// Animation
			image_speed = 0;
			image_index = 1;
		}
		break;
	case states.move:
		// Move
		pos_x += hor_speed * dir;
		image_speed = 1;
			
		// Check for floor
		var find_floor = tile_find_v(pos_x, pos_y + 15, true, plane)[0];
		if (find_floor >= 12 or find_floor < -8) {
			state = states.turn;
			timer = 30;
		} else {
			if !(--timer) {
				// Reset timer
				timer = 16;
				
				// Create smoke every 16 frames
				var smoke = instance_create_vfx(pos_x - 19 * dir, pos_y - 1, obj_motobug_smoke, true);
				smoke.owner = 1;
			}
			pos_y += find_floor;
		}
		break;
	case states.turn:
		// Loop animation
		if (floor(image_index) > 1) {
			image_index = 0;
		}
		
		// Change direction
		if !(--timer) {
			state = states.move;
			dir *= -1;
		}
		break;
}

// Update hitbox
instance_update_hitbox();
