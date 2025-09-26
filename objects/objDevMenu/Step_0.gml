/// @description Get player data
player_data = "";
with (objPlayer)
{
	// Display movement properties
	other.player_data += "STATE: " + script_get_name(state) + "\n\n";
	other.player_data += "LAYER: " + string(collision_layer) + "\n\n";
	other.player_data += "GRAVITY DIRECTION: " + string(gravity_direction) + "\n\n";
	other.player_data += "SPEED:" + string_format(x_speed, 3, 2) + " |" + string_format(y_speed, 3, 2) + "\n\n";
	other.player_data += "ANGLE: " + string_format(angle, 3, 2) + "\n\n";
	other.player_data += "MASK DIRECTION: " + string(mask_direction) + "\n\n";
	other.player_data += "CONTROL LOCK: " + string(control_lock_time);
	
	// Abort if dead
	if (state == player_is_dead) exit;
	
	// Rotate the player's gravity direction
	if (keyboard_check_pressed(ord("A")) or keyboard_check_pressed(ord("S")))
	{
		gravity_direction = (keyboard_key == ord("A")) ? angle_wrap(gravity_direction - 90) : angle_wrap(gravity_direction + 90);
		camera.gravity_direction = gravity_direction;
		if (not on_ground) player_set_ground(noone);
	}
	
	// Transition to the debugging state
	if (keyboard_check_pressed(ord("D")))
	{
		if (state != player_is_debugging)
		{
			player_is_debugging(-1);
		}
		else player_is_falling(-1);
	}
	
	// Gain 50 rings
	if (keyboard_check_pressed(ord("F")))
	{
		player_get_rings(50);
	}
	
	// Restart stage
	if (keyboard_check_pressed(ord("R")))
	{
		transition_to(room);
	}
}