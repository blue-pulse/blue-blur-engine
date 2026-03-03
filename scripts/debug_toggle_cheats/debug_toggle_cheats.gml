function debug_toggle_cheats() {
	// Close game
	if (keyboard_check_pressed(vk_escape)) {
		game_end();
	}
	
	// Toggle fullscreen
	if (keyboard_check_pressed(vk_f12)) {
		global.is_fullscreen = !global.is_fullscreen;
		screen_set_properties();
	}
	
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
	
	// Focus random object
	if (keyboard_check_pressed(vk_numpad3)) {
		if (camera_get_target() != Player) {
			camera_set_target(Player);
		} else {
			camera_set_target(obj_resource);
		}
	}
	
	// Toggle HUD
	if (keyboard_check_pressed(vk_numpad5)) {
		obj_hud.viewable = !obj_hud.viewable
	}
}
