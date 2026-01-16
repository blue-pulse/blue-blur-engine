// Inherit the parent event
event_inherited();

// Air movement
y = ystart + dcos(ticks * 3) * 6;

// State machine
switch (state) {
	case 0:
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
						state = 1;
						enemy_invoke_alert(18, 20);
						animation_play(anim_attack);
					}
				}
			}	
		}
		break;
		
	case 1:
		// Shoot
		if (animation_get_frame() == 5) {
			attack_delay = 45;
			vfx_create(x, y + 15, obj_balloon_bullet, { vspeed: bullet_speed }, true);
		}
		
		// Return to idle
		else if (animation_ended()) {
			state = 0;
			animation_play(anim_idle);
		}
		break;
}
