// Stop room persistance
is_paused = false;
paused_room = noone;
room_persistent = false;

// Logic
switch (option_active) {
	// Restart room
	case 1:
		stage_restart_room(10);
		break;
			
	// Exit room
	case 2:
		if (room != rm_hub_world) {
			stage_exit_room(15);
		} else {
			stage_restart_game(10);
		}
		break;
}
