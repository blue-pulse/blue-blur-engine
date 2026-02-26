// Variables
var item = index;
vspeed = 0;

// Give reward to player
with (owner) {
	// Abort if dead
	if (state == player_state_death) {
		break;
	}
	
	// Get reward type
	switch (item) {
		case items.rings_5:
			monitor_grant_5_rings();
			break;
			
		case items.rings_10:
			monitor_grant_10_rings();
			break;
			
		case items.rings_rand:
			monitor_grant_random_rings();
			break;
			
		case items.life:
			player_add_lives(1);
			break;
			
		case items.stamina:
			monitor_grant_stamina();
			break;
			
		default:
			audio_play_sfx(snd_monitor_error, REPLACE);
			break;
	}
}

// Finish
alarm_set(1, 32);
