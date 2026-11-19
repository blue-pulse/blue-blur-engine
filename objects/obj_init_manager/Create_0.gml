// Variables
is_started = game_is_initialized();
is_loading = false;
is_ready = false;
next_room = (is_started) ? (rm_home) : (rm_title);
if (REPLAY_SCENARIO != "") {
	next_room = replay_define_scenarios()[$ REPLAY_SCENARIO].room;
}

// Logic
switch (room) {
	// Start game
	case rm_init_game:
		is_loading = true;
		is_ready = framework_start();
		break;
		
	// Stop game
	case rm_stop_game:
		framework_end();
		break;
}
