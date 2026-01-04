function player_reaction_monitor(object) {
	// Rebound in air
	if (state == player_state_homing) {
		player_set_state(player_state_airbone);
		hor_speed = 0;
		ver_speed = -jump_height div 1;
	} else if (!is_grounded) {
		ver_speed *= -1;
	}
	
	// Create icon
	var item = vfx_create(object.x, object.y, obj_monitor_item, true);
	with (item) {
		image_index = object.item;
		owner = other.id;
	}
	
	// Destroy monitor and reticle
	instance_destroy(obj_reticle);
	instance_destroy(object);
	
	// Abort state
	return true;
}
