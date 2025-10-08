function player_reaction_badnik(obj)
{
	// Take damage if not in an attacking state
	if (not (is_rolling or invincibility_timer > 0))
	{
		// Abort state if successful
		return player_get_hit(obj);
	}
	
	// Rebound in air
	var homing_rebound = false;
	if (state == player_is_homing)
	{
		// Stop moving and bounce
		state = player_is_falling;
		hor_speed = 0;
		ver_speed = -jump_height div 1;
		homing_rebound = true;
	}
	else if (not is_grounded)
	{
		// Weigh down slightly
		if (ver_speed < 0 and collision_box_vertical(hor_radius, -ver_radius, mask_direction, obj) != noone)
		{
			++ver_speed;
		}
		else if (ver_speed >= 0 and collision_box_vertical(hor_radius, ver_radius, mask_direction, obj) != noone)
		{
			// Bounce
			ver_speed *= -1;
		}
	}
	
	// Scoring
	var bonus = 100;
	var index = 1;
	
	if (++score_combo > 15)
	{
		bonus = 10000;
		index = 5;
	}
	else if (score_combo > 3)
	{
		bonus = 1000;
		index = 4;
	}
	else if (score_combo > 2)
	{
		bonus = 500;
		index = 3;
	}
	else if (score_combo > 1)
	{
		bonus = 200;
		index = 2;
	}
	
	global.score += bonus;
	instance_create_layer(obj.x, obj.y, "Overlays", objPoints, { image_index : index });
	
	// Sound
	//audio_play_sfx(sfxDestroy);
	
	// Destroy badnik and reticle
	instance_destroy(objReticle);
	instance_destroy(obj);
	
	// Abort state if rebounded from a homing attack
	return homing_rebound;
}