// Variables
var _view_left = camera_get_view_x(view_camera[0]) - cull.offset;
var _view_top = camera_get_view_y(view_camera[0]) - cull.offset;
var _view_right = camera_get_view_width(view_camera[0]) + cull.margin;
var _view_bottom = camera_get_view_height(view_camera[0]) + cull.margin;

// Deactivate resources
instance_deactivate_object(obj_resource);

// Activate resources around player
if (camera_get_target() != obj_player and instance_exists(obj_player)) {
	var _player_left = obj_player.x - cull.offset;
	var _player_top = obj_player.y - cull.offset;
	instance_activate_region(_player_left, _player_top, cull.margin, cull.margin, true);
}

// Activate resources
instance_activate_region(_view_left, _view_top, _view_right, _view_bottom, true);

// Restart alarm
alarm_set(0, cull.freq);
