function player_reaction_monitor(obj, side)
{
	// Top collision
	if (side == DIR_TOP)
	{
		// Knock down monitor
		obj.vspeed = -2;
		obj.gravity = 0.21875;
		
		// The monitor is too flat to land on; no need to abort state
		return false;
	}
	
	// Ignore if...
	if (ver_speed < 0 or not is_rolling) return false; // Moving upwards or not is_rolling
	if (side == DIR_BOTTOM and is_grounded) return false; // Spinning on top of the monitor
	
	// Rebound in air
	if (state == player_is_homing)
	{
		state = player_state_airbone;
		hor_speed = 0;
		ver_speed = -jump_height div 1;
	}
	else if (not is_grounded)
	{
		ver_speed *= -1;
	}
	
	// Create icon
	with (instance_create_layer(obj.x, obj.y - 5, layer, objMonitorIcon))
	{
		image_index = obj.icon_index;
		player_id = other.id;
	}
	
	// Sound
	//audio_play_sfx(sfxDestroy);
	
	// Destroy monitor and reticle
	instance_destroy(obj_reticle);
	instance_destroy(obj);
	
	// Abort state
	return true;
}