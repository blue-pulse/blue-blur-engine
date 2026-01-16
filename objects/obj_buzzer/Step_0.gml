// Inherit parent
event_inherited();

// State machine
switch (state) {
	// Fly
	case 0:
		// Turn around
		if (x < left_goal or x > right_goal) {
			state = 1;
			hspeed = 0;
			can_attack = true;
			animation_play(anim_turn);
		}

		// Shoot
		else if (can_attack) {
			var player = instance_nearest(x, y, Player);
			if (player != noone and y < player.y) {
				var target_dist = x - player.x;
				if (abs(target_dist) < attack_range and sign(target_dist) != dir) {
					state = 2;
					hspeed = 0;
					can_attack = false;
					enemy_invoke_alert(-15, 23);
					animation_play(anim_attack);
				}
			}
		}
		break;
		
	// Turn
	case 1:
		if (animation_ended()) {
			state = 0;
			dir *= -1;
			hspeed = fly_speed * dir;
			animation_play(anim_fly);
		}
		break;
		
	// Attack
	case 2:
		// Shoot
		if (animation_get_frame() == 8) {
			vfx_create(x + 16 * dir, y + 13, obj_buzzer_bullet, {
				hspeed: bullet_speed * dir,
				vspeed: bullet_speed,
			}, true);
		}
		
		// Return to patrol
		else if (animation_ended()) {
			state = 0;
			hspeed = fly_speed * dir;
			animation_play(anim_fly);
		}
		break;
}
