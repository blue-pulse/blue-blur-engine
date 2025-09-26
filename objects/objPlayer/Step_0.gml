/// @description State machine
state(0);
if (state == player_is_dead) exit;

// Update position table
array_delete(x_table, 0, 1);
array_delete(y_table, 0, 1);
array_push(x_table, x);
array_push(y_table, y);

// Update camera position
camera.x = x div 1;
camera.y = y div 1;

// Reset camera panning
if (camera.panning_oy != 0)
{
	if ((state != player_is_looking and state != player_is_crouching) or camera_look_time > 0)
	{
		camera.panning_oy -= 2 * sign(camera.panning_oy);
	}
}