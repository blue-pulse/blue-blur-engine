// Variables
var player_info = "";

// Get player data
with (Protagonist) {	
	// Early exit
	if (state == player_state_death) {
		exit;
	}
	
	// Display movement properties
	player_info += "FPS:	" + string_format(fps, 3, 0) + "\n\n";
	player_info += "HSPEED:	" + string_format(hor_speed, 3, 2) + "\n\n";
	player_info += "VSPEED:	" + string_format(ver_speed, 3, 2) + "\n\n";
	player_info += "ANGLE:	" + string_format(angle, 3, 2) + "\n\n";
	player_info += "MASK DIR:	" + string(mask_direction) + "\n\n";
	player_info += "GRAVITY DIR:	" + string(gravity_direction) + "\n\n";
	player_info += "GROUND LOCK:	" + string(ground_lock) + "\n\n";
	player_info += "AIR LOCK:	" + string(air_lock) + "\n\n";
	player_info += "PLANE:	" + string(plane) + "\n\n";
	player_info += "OLD STATE:	" + script_get_name(state_prev) + "\n\n";
	player_info += "NEW STATE:	" + script_get_name(state) + "\n\n";
	player_info += "ANIMATION:	" + string(snip_get_sprite(animation)) + "\n\n";
	
	// Handle cheats
	debug_toggle_cheats();
}

// Set player data
player_data = player_info;
