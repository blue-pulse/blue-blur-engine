// Inherit parent
event_inherited();

// State machine
switch (state) {
	// Fly
	case buzzer_states.fly:
		// Turn around
		var out_of_bounds = (!dir and x <= left_goal) or (dir and x >= right_goal);
		if (out_of_bounds) {
			can_attack = true;
			enemy_invoke_turn(buzzer_states.turn);
		}

		// Shoot
		else if (can_attack) {
			var player = instance_nearest(x, y, Player);
			if (player != noone and y < player.y) {
				var target_dist = x - player.x;
				if (abs(target_dist) < attack_range and sign(target_dist) != dir) {
					state = buzzer_states.attack;
					state_timer = 0;
					hspeed = 0;
					can_attack = false;
					enemy_invoke_alert(-15, 23);
				}
			}
		}
		break;

	// Turn
	case buzzer_states.turn:
		if (++state_timer >= turn_steps) {
			state = buzzer_states.fly;
			dir *= -1;
			hspeed = movement_speed * dir;
		}
		break;

	// Attack
	case buzzer_states.attack:
		// Shoot
		state_timer++;
		if (state_timer == fire_at_step) {
			vfx_create(x + 16 * dir, y + 13, obj_buzzer_bullet, {
				hspeed: bullet_speed * dir,
				vspeed: bullet_speed,
			}, true);
		}

		// Return to patrol
		if (state_timer >= attack_steps) {
			state = buzzer_states.fly;
			hspeed = movement_speed * dir;
		}
		break;
}
