function player_reaction_dash_panel(obj)
{
	// Ignore if airborne, the dash panel is already triggered, or we're not inside it
	if (not is_grounded or obj.alarm[0] != -1 or
		not point_in_rectangle(x, y, obj.bbox_left, obj.bbox_top, obj.bbox_right, obj.bbox_bottom))
	{
		return false;
	}
	
	// Trigger
	obj.alarm[0] = 5;
	//audio_play_sfx(sfxPeelout);
	
	// Launch
	image_xscale = obj.image_xscale;
	hor_speed = max(abs(hor_speed), 12) * image_xscale;
	gnd_lock = 16;
	
	// Roll, if applicable
	if (obj.force_roll and state != player_is_rolling)
	{
		// Abort state
		player_is_rolling(-1);
		return true;
	}
	
	// Do not abort state
	return false;
}