// Skip frame
if (scene_is_changing()) {
	exit;
}

// Main menu
if (show_menu) {
	// Early exit
	if (input_pressed(vb_back)) {
		layer_hspeed(flag_layer, 10);
		mixer_play_effect(snd_menu_back, mixer_modes.swap);
		scene_change(rm_title, 40, c_black, true);
		exit;
	}
	
	// Stop moving flag
	if (layer_get_x(flag_layer) > flag_xstart) {
		layer_x(flag_layer, flag_xstart);
		layer_hspeed(flag_layer, 0);
		layer_vspeed(flag_layer, 0.5);
	}
	
	// Stop moving options 
	for (var _i = 0; _i < options_count; ++_i) {
		var _option = options[_i];
		var _pos_x = _option.x;
		
		if (_pos_x == WIDTH) {
			_option.state = (option_active == _i ? 1 : 0);
		} else if (_pos_x < WIDTH) {
			_option.x = WIDTH;
			_option.hspeed = 0;
		}
	}
	
	// Select option
	var _delta = input_pressed(vb_down) - input_pressed(vb_up);
	if (_delta != 0) {
		mixer_play_effect(snd_menu_select, mixer_modes.swap);
		option_active = (_delta + option_active + options_count) % options_count;
	}
	
	if (input_pressed(vb_accept)) {
		// Variables
		show_menu = false;
		layer_vspeed(flag_layer, 0);
		menu_select_option(3, 2);
		
		// Load option
		switch (option_active) {
			// Select slot
			case 0:
				options[0].hspeed = 20;
				options[1].hspeed = 16;
				options[2].hspeed = 12;
				layer_hspeed(flag_layer, -20);
				mixer_play_effect(snd_menu_confirm, mixer_modes.swap);
				break;
			
			// Settings
			case 1:
				options[0].hspeed = 12;
				options[1].hspeed = 16;
				options[2].hspeed = 20;
				layer_hspeed(flag_layer, -20);
				mixer_play_effect(snd_menu_confirm, mixer_modes.swap);
				break;
				
			// Quit
			case 2:
				options[0].hspeed = 12;
				options[1].hspeed = 16;
				options[2].hspeed = 20;
				layer_hspeed(flag_layer, 9.5);
				mixer_play_effect(snd_quit_game);
				framework_quit();
				break;
		}
	}
}

else {
	// Stop moving flag
	if (layer_get_x(flag_layer) < flag_xend) {
		layer_x(flag_layer, flag_xend);
		layer_hspeed(flag_layer, 0);
		layer_vspeed(flag_layer, 0.5);
	}
	
	// Stop moving options 
	for (var _i = 0; _i < options_count; ++_i) {
		var _option = options[_i];
		if (_option.x >= WIDTH + options_offscreen) {
			_option.hspeed = 0;
		}
	}
	
	// Select slot
	if (option_active == 0) {
		home_select_play();

		if (input_pressed(vb_accept)) {
			game_load_save(slot_active);
			mixer_play_effect(snd_menu_confirm);
			scene_change(next_room, 60, c_black, true);
			exit;
		}
	}

	// Show main menu
	if (input_pressed(vb_back)) {
		// Variables
		show_menu = true;
		layer_hspeed(flag_layer, 20);
		layer_vspeed(flag_layer, 0);
		
		// Unload option
		switch (option_active) {
			// Select slot
			case 0:
				options[0].hspeed = -20;
				options[1].hspeed = -16;
				options[2].hspeed = -12;
				break;
			
			// Settings
			case 1:
				options[0].hspeed = -12;
				options[1].hspeed = -16;
				options[2].hspeed = -20;
				break;
		}
	}
}
