// Variables
var view_left = camera_get_view_x(View) - CULL_OFFSET;
var view_top = camera_get_view_y(View) - CULL_OFFSET;
var view_right = WIDTH + CULL_MARGIN;
var view_bottom = HEIGHT + CULL_MARGIN;

// Deactivate resources
instance_deactivate_object(obj_resource);

// Activate resources around player
if (camera_get_target() != Player) {
	var player_left = Player.x - CULL_OFFSET;
	var player_top = Player.y - CULL_OFFSET;
	instance_activate_region(player_left, player_top, CULL_MARGIN, CULL_MARGIN, true);
}

// Activate resources
instance_activate_region(view_left, view_top, view_right, view_bottom, true);

// Restart alarm
alarm_set(0, CULL_FREQ);
