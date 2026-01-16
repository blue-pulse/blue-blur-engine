// Inherit the parent event
event_inherited();

// Move through the air
if (!is_attacking and !turn_wait) {
	if (hspeed != 0) {
		// Turn around
		if (x < xstart - movement_dist or x > xstart + movement_dist) {
			hspeed = 0;
			turn_wait = 30;
		}
		
		// Prepare to fire at the player
		else if (can_shoot) {
			var player = instance_nearest(x, y, Player);
			if (player != noone and y < player.y) {
				var dist_to_target = x - player.x;
				if (abs(dist_to_target) < 60 and sign(dist_to_target) != dir) {
					hspeed = 0;
					can_shoot = false;
					is_attacking = true;
					animation_play(anim_shoot);
				}
			}
		}
	}
	
	// Flip if previously turning around
	else {
		// Flip
		if (!animation_is_playing(anim_shoot)) {
			dir = -dir;
			can_shoot = true;
			animation_play(anim_turn);
		}
		hspeed = 1.5 * dir;
	}
}

// Reduce turn timer
else if (turn_wait) {
	--turn_wait;
}

// Shooting
else if (is_attacking) {
	if (animation_get_frame() == 8) {
		vfx_create(x + 12 * dir, y + 12, obj_stinger_bullet, {
			image_xscale: dir,
			hspeed: 1.5 * dir,
			vspeed: 1.5,
		});
	} else if (animation_ended()) {
		is_attacking = false;
		animation_play(anim_fly);
	}
}
