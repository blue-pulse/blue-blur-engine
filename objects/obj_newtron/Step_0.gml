// Inherit the parent event
event_inherited();

// State machine
switch (state) {
	// Waiting
	case 0:
		var player = instance_nearest(x, y, obj_player);
		if (player != noone) {
			var x_diff = player.x - x;
			var y_diff = player.y - y;
			if (abs(x_diff) < attack_range and abs(y_diff) < 40) {
				dir = sign(x_diff);
				state = 1;
				visible = true;
				animation_play(anim_fadein);
			}
		}
		break;
	
	// Fading in
	case 1:
		if (animation_ended()) {
			state = 2;
			attack_delay = 60;
			animation_play(anim_attack);
		}
		break;
	
	// Shooting
	case 2:
		if (--attack_delay == 30) {
			vfx_create(x + 14 * dir, y - 3, obj_newtron_bullet, { 
				hspeed: bullet_speed * dir,
			});
		} else if (!attack_delay) {
			state = 3;
			animation_play(anim_fadeout);
		}
		break;
	
	// Fading out
	case 3:
		if (animation_get_frame() < 1) {
			instance_terminate();
		}
		break;
}
