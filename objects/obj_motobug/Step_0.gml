// Inherit the parent event
event_inherited();

// State machine
switch (state) {
	// Move
	case 0:
		// Meeting with floor
		if (place_meeting(x, y + 1, obj_solid)) {
			// Stop falling
			vspeed = 0;
			
			// Move outside of floor
			while (place_meeting(x, y, obj_solid)) {
				--y;
			}

			// Create smoke every 16 frames
			if (!smoke_timer--) {
				smoke_timer = 16;
				part_particles_create(Particles, x - 16 * dir, y + 3, vfx_smoke, 1);
			}
			
			// Turn around
			var out_of_bounds = (!dir and x <= left_goal) or (dir and x >= right_goal);
			if (out_of_bounds or !collision_point(x + 8 * dir, y + 20, obj_solid, false, false)) {
			    enemy_invoke_turn();
				break;
			}
		}
		
		// Fall
		else {
			vspeed = 2;
		}
		
		// Move until meeting wall
		if (place_meeting(x + hspeed, y - 1, obj_solid)) {
			// Move outside of wall
			while (place_meeting(x, y, obj_solid)) {
				--x;
			}
			
			// Turn around
			enemy_invoke_turn();
			break;
		}
		break;
		
	// Turn
	case 1:
		if (animation_ended()) {
			state = 0;
			dir *= -1;
			hspeed = movement_speed * dir;
			animation_play(anim_attack);
		}
		break;
}
