// Stop room persistance
is_paused = false;
room_persistent = false;

// Logic
if (selected_option != 0) {
    switch (selected_option) {
		// Restart room
        case 1:
			stage_restart_room();
            break;
			
		// Exit room
        case 2:
			if (room != rm_hub_world) {
				stage_exit_room();
			} else {
				stage_restart_game();
			}
            break;
    }
}
