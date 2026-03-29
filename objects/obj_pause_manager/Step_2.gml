// Pause game
if (!in_process) {
	// Early exit
	if (!pause_is_allowed()) {
		exit;
	}
	
	// Variables
	is_paused = true;
	in_process = true;
	paused_room = room;
	option_active = 0;
	
	// Save surface
	pause_surface = surface_create(room_width, room_height);
	surface_copy(pause_surface, 0, 0, application_surface);
	
	// SFX
	audio_pause_all();
	audio_play_sfx(snd_pause_start, REPLACE);
		
	// Save level
	room_persistent = true;
	room_goto(rm_pause);
}

// Allow player to select options
else {
	// Early exit
	if (input_pressed(vb_back)) {
		option_active = 0;
		pause_resume();
		exit;
	}
	
	// Select option
	var delta = input_pressed(vb_down) - input_pressed(vb_up);
	if (delta != 0) {
		audio_play_sfx(snd_menu_select, REPLACE);
		option_active = (delta + option_active + options_count) % options_count;
	}

	// Continue
	if (input_pressed(vb_accept)) {
		if (options[option_active].state == 3) {
			// Option is locked
			audio_play_sfx(snd_menu_deny, REPLACE);
		} else {
			pause_resume();
		}
	} 
	
	// Gray-out options
	else {
		// Set options state
		menu_select_option(0, 1);
		
		// Lock when in hub world
		if (paused_room == rm_hub_world) {
			options[1].state = (option_active == 1 ? 3 : 2);
		}
	}
}
