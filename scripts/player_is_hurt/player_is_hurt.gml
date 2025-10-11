function player_is_hurt(phase)
{
	switch (phase)
	{
		case INIT:
		{
			// Set state and flags
			state = player_is_hurt;
	        is_rolling = false;
			
			// Set air state
			player_set_ground(noone);
			
			// Animate
			animation_index = "hurt";
			timeline_speed = 1;
			image_angle = gravity_direction;
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_air())
			{
				recovery_timer = 120;
				exit;
			}
			
			// Landing
			if (is_grounded)
			{
				// Stop moving
				hor_speed = 0;
				
				// Gain temporary invulnerability
				recovery_timer = 120;
				
				// Stand
				player_set_state(player_state_idle);
				exit;
			}
			
			// Gravity
			if (ver_speed < grav_cap) ver_speed = min(ver_speed + grav_recoil, grav_cap);
		}
	}
}