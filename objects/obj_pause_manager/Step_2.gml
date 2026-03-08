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
	selected_option = 0;
	
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
	var confirm_option = input_pressed_many([vb_a, vb_start]);
	if (input_pressed(vb_back)) {
		selected_option = 0;
		pause_resume();
		exit;
	}
	
	// Variables
	var input_up = input_pressed(vb_up);
	var input_down = input_pressed(vb_down);
	
	// Select option
	selected_option += input_down - input_up;
	selected_option = (selected_option + options_length) % options_length;
	
	// SFX
	if (input_up or input_down) {
		audio_play_sfx(snd_menu_select, REPLACE);
	}

	// Continue
	if (confirm_option) {
		// Option is locked
		if (options[selected_option].state == 3) {
			audio_play_sfx(snd_menu_deny, REPLACE);
		}
		
		// Choose option
		else {
			pause_resume();
		}
	} 
	
	// Gray-out options
	else {
		// Determinar el estado de las opciones
		for (var i = 0; i < options_length; ++i) {
			var new_state = (selected_option == i) ? (1) : (0);
			options[i].set_state(new_state);
		}
		
		// Lock when in hub world
		if (paused_room == rm_hub_world) {
			var new_state = (selected_option == 1) ? (3) : (REPLACE);
			options[1].set_state(new_state);
		}
	}
}
