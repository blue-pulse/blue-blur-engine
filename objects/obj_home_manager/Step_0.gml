// Skip frame
if (is_fading) {
	exit;
}

// Main menu
if (show_menu) {
	// Early exit
	if (input_pressed(vb_back)) {
		layer_hspeed(flag_layer, 10);
		audio_play_sfx(snd_menu_back, REPLACE);
		room_fadeto(rm_title, 40, c_black, true);
		exit;
	}
	
	// Stop moving flag
	if (layer_get_x(flag_layer) > flag_xstart) {
		layer_x(flag_layer, flag_xstart);
		layer_hspeed(flag_layer, 0);
		layer_vspeed(flag_layer, 0.5);
	}
	
	// Stop moving options 
	for (var i = 0; i < options_count; ++i) {
		var option = options[i];
		var pos_x = option.x;
		
		if (pos_x == WIDTH) {
			option.state = (option_active == i ? 1 : 0);
		} else if (pos_x < WIDTH) {
			option.x = WIDTH;
			option.hspeed = 0;
		}
	}
	
	// Select option
	var delta = input_pressed(vb_down) - input_pressed(vb_up);
	if (delta != 0) {
		audio_play_sfx(snd_menu_select, REPLACE);
		option_active = (delta + option_active + options_count) % options_count;
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
				audio_play_sfx(snd_menu_confirm, REPLACE);
				break;
			
			// Settings
			case 1:
				options[0].hspeed = 12;
				options[1].hspeed = 16;
				options[2].hspeed = 20;
				layer_hspeed(flag_layer, -20);
				audio_play_sfx(snd_menu_confirm, REPLACE);
				break;
				
			// Quit
			case 2:
				options[0].hspeed = 12;
				options[1].hspeed = 16;
				options[2].hspeed = 20;
				layer_hspeed(flag_layer, 9.5);
				audio_play_sfx(snd_quit_game);
				framework_stop();
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
	for (var i = 0; i < options_count; ++i) {
		var option = options[i];
		if (option.x >= WIDTH + options_offscreen) {
			option.hspeed = 0;
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
