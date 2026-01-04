function player_receive_damage(object, instant_kill=false) {
	// Exit if player can't be damaged
	if (!instant_kill and recovery_timer) {
		return false;
	}
	
	// Exit if invalid state
	if (array_contains(damage_denied_state, state)) {
		return false;
	}
	
	// VFX
	screen_shake(15);
	
	// SFX
	if (!audio_is_playing(snd_ring_scatter)) {
		switch (object.object_index) {
			// Spikes sound
			case obj_spikes:
				audio_play_sfx(snd_player_stabbed, REPLACE);
				break;
			
			// Default hurt sound
			default:
				audio_play_sfx(snd_player_hurt, REPLACE);
				break;
		}
	}

	// Movement
	if (is_underwater) {
		hor_speed = (floor(x) > floor(other.x)) ? (1) : (-1);
		ver_speed = -2;
		grav_recoil = 0.0625;
	} else {
		hor_speed = (floor(x) > floor(other.x)) ? (2) : (-2);
		ver_speed = -4;
		grav_recoil = 0.1875;
	}
	
	// Kill player
	if (instant_kill or !rings) {
		player_set_state(player_state_death);
	}
	
	// Drop rings
	else {
		player_drop_rings();
		player_set_state(player_state_hurt);
	}

	// Player was hit
	return true;
}
