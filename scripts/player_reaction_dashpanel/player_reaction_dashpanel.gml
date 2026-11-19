function player_reaction_dashpanel(object) {
	// Early exit
	if (!is_grounded or !object.is_usable or array_contains(damage_denied_state, state)) {
		return false;
	}
	
	// Trigger object
	with (object) {
		is_usable = false;
		alarm_set(0, 16);
	}
	
	// FX
	screen_shake(7);
	mixer_play_effect(snd_dashpanel, mixer_modes.swap);

	// Launch player
	dir = object.dir;
	hor_speed = max(abs(hor_speed), 12) * dir;
	
	// Force roll
	if (object.force_roll) {
		force_roll = true;
	}
	
	// Set state
	player_set_state(player_state_dashpanel);
	return true;
}
