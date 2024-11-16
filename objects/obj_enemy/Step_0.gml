// Early exit
if (!instance_exists(Player)) {
	return;
}

// State logic
switch (state) {
	case states.hurt:
		// Destroy enemy
		enemy_destroy_badnik();
		break;
	case states.knockout:
		// Send flying
		image_speed = 0;
		pos_x += Player.hor_speed;
		pos_y += (Player.is_grounded) ? (-3.5) : (Player.ver_speed);
		angle += 35;
		break;
}

// When colliding with the player
if (hitbox_in_hitbox(hitbox, Player.hitbox)) {
	// Destroy the enemy when attacked
	if (!Player.is_boosting and array_contains(states_that_hurt, Player.state)) {
		// Make player bounce if they are airborne
		if (!Player.is_grounded and Player.state != states.stomp) {
			player_set_state(states.jump, false);
			if (floor(Player.pos_y) > pos_y or Player.ver_speed < 0) {
				Player.ver_speed -= 1 * sign(Player.ver_speed);	
			} else if (Player.ver_speed > 0) {
				Player.ver_speed = -Player.ver_speed;
			}
		}
	
		// Destroy enemy
		screen_shake(10);
		state = states.hurt;
	} 
	
	// Destroy the enemy when boosting
	else if (Player.is_boosting) {
		// VFX
		screen_shake(25);
		instance_create_vfx(pos_x, pos_y, obj_explosion_spark, false);
	
		// Send flying
		alarm[0] = 15;
		targetable = false;
		state = states.knockout;
	}
	
	// Hurt the player
	else {
		player_damage();
	}
}
