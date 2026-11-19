// Variables
var _view_left = camera_get_view_x(view_camera[0]) - CULL_OFFSET;
var _view_top = camera_get_view_y(view_camera[0]) - CULL_OFFSET;
var _view_right = camera_get_view_width(view_camera[0]) + CULL_MARGIN;
var _view_bottom = camera_get_view_height(view_camera[0]) + CULL_MARGIN;

// Deactivate actors
instance_deactivate_object(obj_actor);

// Activate actors around player
if (camera_get_target() != obj_player and instance_exists(obj_player)) {
	var _player_left = obj_player.x - CULL_OFFSET;
	var _player_top = obj_player.y - CULL_OFFSET;
	instance_activate_region(_player_left, _player_top, CULL_MARGIN, CULL_MARGIN, true);
}

// Activate actors
instance_activate_region(_view_left, _view_top, _view_right, _view_bottom, true);

// Restart alarm
alarm_set(0, CULL_INTERVAL);
