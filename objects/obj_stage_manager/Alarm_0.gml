// Variables
var view_left = camera_get_view_x(View) - cull.offset;
var view_top = camera_get_view_y(View) - cull.offset;
var view_right = camera_get_view_width(View) + cull.margin;
var view_bottom = camera_get_view_height(View) + cull.margin;

// Deactivate resources
instance_deactivate_object(obj_resource);

// Activate resources around player
if (camera_get_target() != Player and instance_exists(Player)) {
	var player_left = Player.x - cull.offset;
	var player_top = Player.y - cull.offset;
	instance_activate_region(player_left, player_top, cull.margin, cull.margin, true);
}

// Activate resources
instance_activate_region(view_left, view_top, view_right, view_bottom, true);

// Restart alarm
alarm_set(0, cull.freq);
