// Variables
var view_left = camera_get_view_x(view_camera[0]) - cull.offset;
var view_top = camera_get_view_y(view_camera[0]) - cull.offset;
var view_right = camera_get_view_width(view_camera[0]) + cull.margin;
var view_bottom = camera_get_view_height(view_camera[0]) + cull.margin;

// Deactivate resources
instance_deactivate_object(obj_resource);

// Activate resources around player
if (camera_get_target() != obj_player and instance_exists(obj_player)) {
	var player_left = obj_player.x - cull.offset;
	var player_top = obj_player.y - cull.offset;
	instance_activate_region(player_left, player_top, cull.margin, cull.margin, true);
}

// Activate resources
instance_activate_region(view_left, view_top, view_right, view_bottom, true);

// Restart alarm
alarm_set(0, cull.freq);
