// Inherit the parent event
event_inherited();

// State machine
switch (state) {
	// Move
	case 0:
		// Meeting with floor
		if (place_meeting(x, y + 1, obj_solid)) {
			// Move outside of floor
			while (place_meeting(x, y, obj_solid)) {
				--y;
			}

			// Create smoke every 16 frames
			if (!smoke_timer--) {
				smoke_timer = 16;
				part_particles_create(Particles, x - 16 * dir, y + 3, vfx_smoke, 1);
			}
						
			// Variables
			hspeed = movement_speed * dir;
			vspeed = 0;
			var out_of_bounds = (x < left_goal) or (x > right_goal);
			
			// Turn around
			if (out_of_bounds or !collision_point(x + 8 * dir, y + 20, obj_solid, false, false)) {
			    enemy_invoke_turn();
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
			if (dir == sign(hspeed)) {
				enemy_invoke_turn();
			}
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
