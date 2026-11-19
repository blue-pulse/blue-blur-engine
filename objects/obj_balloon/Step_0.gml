// Inherit the parent event
event_inherited();

// Air movement
y = ystart + dcos(global.framecount * 3) * 6;

// State machine
switch (state) {
	case balloon_states.idle:
		// Idle
		if (attack_delay > 0) {
			attack_delay--;
		}

		// Attack
		else {
			var _player = instance_nearest(x, y, obj_player);
			if (_player != noone) {
				var _diff_y = _player.y - y;
				if (_diff_y > 0 and _diff_y <= attack_range) {
					if (abs(_player.x - x) <= 64) {
						state = balloon_states.attack;
						state_timer = 0;
						enemy_invoke_alert(18, 20);
					}
				}
			}
		}
		break;

	case balloon_states.attack:
		// Shoot
		state_timer++;
		if (state_timer == fire_at_step) {
			attack_delay = 45;
			vfx_create(x, y + 15, obj_balloon_bullet, { vspeed: bullet_speed }, true);
		}

		// Return to idle
		if (state_timer >= attack_steps) {
			state = balloon_states.idle;
		}
		break;
}
