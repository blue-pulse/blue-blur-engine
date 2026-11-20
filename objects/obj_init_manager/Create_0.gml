// Variables
is_started = game_is_initialized();
is_loading = false;
is_ready = false;
next_room = (is_started) ? (rm_home) : (rm_title);
if (REPLAY_SCENARIO != "") {
	next_room = replay_define_scenarios()[$ REPLAY_SCENARIO].room;

	// Prepare the files of a persistence replay before the game loads them
	if (!is_started) {
		replay_prepare_persistence();
	}
}

// Logic
switch (room) {
	// Start game
	case rm_init_game:
		is_loading = true;
		framework_start();
		is_ready = is_started;
		break;
		
	// Stop game
	case rm_stop_game:
		framework_end();
		break;
}
