function player_reaction_dashpad(object) {
	// Early exit
	if (!is_grounded or !object.usable) {
		return false;
	}
	
	// Trigger
	object.alarm[0] = 5;
	object.usable = false;
	
	// FX
	screen_shake(7);
	audio_play_sfx(snd_dashpad, REPLACE);
	
	// Launch
	dir = object.dir;
	ground_lock = 16;
	hor_speed = max(abs(hor_speed), 12) * dir;
	
	// Force roll
	if (state != player_state_roll and object.force_roll) {
		player_set_state(player_state_roll);
		return true;
	}
	
	// Do not abort state
	return false;
}
