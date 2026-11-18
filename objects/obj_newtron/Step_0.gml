// Inherit the parent event
event_inherited();

// State machine
switch (state) {
	// Waiting
	case newtron_states.wait:
		var _player = instance_nearest(x, y, obj_player);
		if (_player != noone) {
			var _x_diff = _player.x - x;
			var _y_diff = _player.y - y;
			if (abs(_x_diff) < attack_range and abs(_y_diff) < 40) {
				dir = sign(_x_diff);
				state = newtron_states.fade_in;
				state_timer = 0;
				visible = true;
			}
		}
		break;

	// Fading in
	case newtron_states.fade_in:
		if (++state_timer >= fade_in_steps) {
			state = newtron_states.attack;
			state_timer = 0;
		}
		break;

	// Shooting
	case newtron_states.attack:
		state_timer++;
		if (state_timer == fire_at_step) {
			vfx_create(x + 14 * dir, y - 3, obj_newtron_bullet, {
				hspeed: bullet_speed * dir,
			});
		} else if (state_timer >= attack_steps) {
			state = newtron_states.fade_out;
			state_timer = 0;
		}
		break;

	// Fading out
	case newtron_states.fade_out:
		if (++state_timer >= fade_out_steps) {
			instance_terminate();
		}
		break;
}
