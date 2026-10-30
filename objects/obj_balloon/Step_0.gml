// Inherit the parent event
event_inherited();

// Air movement
y = ystart + dcos(ticks * 3) * 6;

// State machine
switch (state) {
	case balloon_states.idle:
		// Idle
		if (attack_delay) {
			attack_delay--;
		}

		// Attack
		else {
			var player = instance_nearest(x, y, Player);
			if (player != noone) {
				var diff_y = player.y - y;
				if (diff_y > 0 and diff_y <= attack_range) {
					if (abs(player.x - x) <= 64) {
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
