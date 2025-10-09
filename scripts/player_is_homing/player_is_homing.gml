function player_is_homing(phase)
{
	switch (phase)
	{
		case INIT:
		{
			// Set state and flags
			state = player_is_homing;
			is_jumping = false;
			break;
		}
		default:
		{
			// Update position
			if (not player_movement_air()) exit;
			
			// Fall if the reticle can no longer be locked on to
			if (not player_can_lock_on(obj_reticle.target))
			{
				is_jumping = true;
				jump_action = false;
				instance_destroy(obj_reticle);
				return player_is_falling(-1);
			}
			
			// Move towards the reticle
			var homing_speed = 12;
			var dir = point_direction(x, y, obj_reticle.x, obj_reticle.y) - mask_direction;
			hor_speed = lengthdir_x(homing_speed, dir);
			ver_speed = lengthdir_y(homing_speed, dir);
		}
	}
}