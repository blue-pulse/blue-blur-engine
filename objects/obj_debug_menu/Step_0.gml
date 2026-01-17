// Variables
var player_info = "";

// Get player data
with (Player) {	
	// Early exit
	if (state == player_state_death) {
		exit;
	}
	
	// Display movement properties
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
	
	// Rotate the player's gravity clockwise
	if (keyboard_check_pressed(vk_add)) {
		gravity_direction = angle_wrap(gravity_direction + 90)
		Camera.gravity_direction = (360 - gravity_direction) mod 360;
		if (!is_grounded) {
			player_set_ground(noone);
		}
	}
	
	// Rotate the player's gravity anticlockwise
	if (keyboard_check_pressed(vk_subtract)) {
		gravity_direction = angle_wrap(gravity_direction - 90);
		Camera.gravity_direction = (360 - gravity_direction) mod 360;
		if (!is_grounded) {
			player_set_ground(noone);
		}
	}
	
	// Transition to the debugging state
	if (keyboard_check_pressed(vk_numpad0)) {
		if (state != player_state_debug) {
			player_set_state(player_state_debug);
		} else {
			player_set_state(player_state_airbone);
		}
	}
	
	// Gain 50 rings
	if (keyboard_check_pressed(vk_numpad1)) {
		player_add_rings(50);
	}
	
	// Restart stage
	if (keyboard_check_pressed(vk_numpad2)) {
		room_fadeto(room);
	}
}

// Set player data
player_data = player_info;
