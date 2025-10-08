function player_is_dead(phase) {
	switch (phase)
	{
		case -1:
		{
			// Set state and flags
			state = player_is_dead;
			is_rolling = false;
			objStage.timer_enabled = false;
			
			// Movement
			ver_speed = -7;
			
			// Remove effects
			instance_destroy(invincibility_effect);
			
			// Animate
			animation_index = "dead";
			image_angle = gravity_direction;
			
			// Sound
			//audio_play_sfx(sfxDeath);
			break;
		}
		default:
		{
			// Update position
			x += dsin(gravity_direction) * ver_speed;
			y += dcos(gravity_direction) * ver_speed;
			
			// Gravity
			if (ver_speed < gravity_cap) ver_speed = min(ver_speed + gravity_force, gravity_cap);
			
			// Finish
			if (not in_view(id, 24) and ver_speed > 3)
			{
				// Deduct lives; is the game over?
				if (--global.lives <= 0 or objStage.time_over)
				{
					//instance_create_layer(0, 0, "Overlays", objGameOver);
				}
				else objStage.reset_time = 60; // If not, restart
				//instance_destroy();
			}
		}
	}
}
