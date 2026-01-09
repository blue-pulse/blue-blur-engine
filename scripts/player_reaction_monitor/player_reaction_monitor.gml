function player_reaction_monitor(object) {
	// Rebound in air
	if (!is_grounded) {
		if (is_rolling) {
			player_set_state(player_state_airbone);
			hor_speed = 0;
			ver_speed = floor(-jump_height);
		} else {
			animation_play(anim_fall_slow);
			ver_speed = floor(-ver_speed);
		}
	}
	
	// Create icon
	vfx_create(object.x, object.y, obj_monitor_item, {
		owner: id,
		index: object.item,
	}, true);
	
	// Destroy monitor and reticle
	instance_destroy(obj_reticle);
	instance_destroy(object);
	
	// Abort state
	return true;
}
