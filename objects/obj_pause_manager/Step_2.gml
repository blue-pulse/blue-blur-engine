// Pause game
if (!allow_pause) {
	// Early exit
	if (!pause_is_allowed()) {
		exit;
	}
	
	// Variables
	is_paused = true;
	allow_pause = true;
	paused_room = room;
	selected_option = 0;
	
	// Save surface
	pause_surface = surface_create(room_width, room_height);
	surface_copy(pause_surface, 0, 0, application_surface);
	
	// SFX
	audio_pause_all();
	audio_play_sfx(snd_pause_start, 2);
		
	// Save level
	room_persistent = true;
	room_goto(rm_pause);
}

// Allow player to select options
else {
	// SFX
	if (input_pressed(vb_up) or input_pressed(vb_down)) {
		audio_play_sfx(snd_menu_select, 2);
	}
	
	// Select option
	selected_option += input_pressed(vb_down) - input_pressed(vb_up);
	selected_option = (selected_option + options_length) % options_length;

	// Confirm option
	if (input_pressed(vb_start) or input_pressed(vb_a)) {
		// Option is locked
		if (options[selected_option].state == 3) {
			audio_play_sfx(snd_menu_deny, 2);
		}
		
		// Choose option
		else {
			// SFX
			audio_play_sfx(snd_menu_confirm, 2);
			audio_play_sfx(snd_pause_stop, 2);
			
			// Go back to the level
			room_goto(paused_room);
			audio_resume_all();

			// Variables
			surface_free(pause_surface);
			pause_surface = noone;
			paused_room = noone;
			allow_pause = false;
			alarm_set(0, 5);
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
			var new_state = (selected_option == 1) ? (3) : (2);
			options[1].set_state(new_state);
		}
	}
}
