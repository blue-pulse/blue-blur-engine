function player_reaction_monitor(object) {
	// Variables
	var change_state = false;
	
	// Rebound in air
	if (state == player_state_homing) {
		// Stop moving and bounce
		player_set_state(player_state_airbone);
		change_state = true;
		
		// Variables
		hor_speed = 0;
		ver_speed = round(-jump_height);
	} else if (!is_grounded) {
		// Move down slightly
		if (ver_speed < 0 and collision_box_vertical(hor_radius, -ver_radius, mask_direction, object)) {
			ver_speed++;
		}
		
		// Bounce
		else if (ver_speed >= 0 and collision_box_vertical(hor_radius, ver_radius, mask_direction, object)) {
			ver_speed *= -1;
			if (!is_rolling) {
				animation_play(anim_fall_slow);
			}
		}
	}
	
	// Create icon
	vfx_create(object.x, object.y, obj_monitor_item, { index: object.item }, true);
	
	// Destroy monitor and reticle
	instance_destroy(obj_reticle);
	instance_destroy(object);
	
	// Should abort state
	return change_state;
}
