function player_reaction_dashpanel(object) {
	// Early exit
	if (!is_grounded or !object.usable) {
		return false;
	}
	
	// Trigger object
	object.alarm[0] = 10;
	object.usable = false;
	
	// Launch player
	dir = object.dir;
	ground_lock = 16;
	hor_speed = max(abs(hor_speed), 12) * dir;
	
	// FX
	image_xscale = dir;
	animation_play(anim_dashpad);
	screen_shake(7);
	audio_play_sfx(snd_dashpanel, REPLACE);
	
	// Force roll
	if (state != player_state_roll and object.force_roll) {
		player_set_state(player_state_roll);
		return true;
	}
	
	// Do not abort state
	return true;
}
