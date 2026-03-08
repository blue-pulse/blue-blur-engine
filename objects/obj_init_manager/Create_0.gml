// Variables
is_active = game_get_initflag();
is_loading = false;
skip_loading = false;
next_room = (is_active) ? (rm_home) : (rm_title);

// Logic
switch (room) {
	// Start game
	case rm_init_game:
		is_loading = true;
		skip_loading = framework_start();
		break;
		
	// Stop game
	case rm_stop_game:
		framework_end();
		break;
}
