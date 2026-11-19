// Draw the layer objects
with (obj_plane_toggler) {
	draw_self();
}

with (obj_plane_setter) {
	draw_self();
}

// Draw player collision mask and animation
with (game_get_player()) {
	var _x_int = floor(x);
	var _y_int = floor(y);
	
	if (other.show_masks) {
		if (mask_direction mod 180 != 0) {
			draw_rectangle_color(_x_int - ver_radius, _y_int - hor_radius, _x_int + ver_radius, _y_int + hor_radius, c_lime, c_lime, c_lime, c_lime, true);
			draw_line_color(_x_int, _y_int - wall_radius, _x_int, _y_int + wall_radius, c_white, c_white);
		} else {
			draw_rectangle_color(_x_int - hor_radius, _y_int - ver_radius, _x_int + hor_radius, _y_int + ver_radius, c_lime, c_lime, c_lime, c_lime, true);
			draw_line_color(_x_int - wall_radius, _y_int, _x_int + wall_radius, _y_int, c_white, c_white);
		}
		draw_line_color(_x_int, _y_int, _x_int + dsin(mask_direction) * ver_radius, _y_int + dcos(mask_direction) * ver_radius, c_white, c_white);
	}
	
	if (other.show_player_frames) {
		animation_debug_draw(x + DEV_FRAMES_OFFSET_X, y + DEV_FRAMES_OFFSET_Y);
	}
}

// Early exit
if (!show_masks and !show_enemy_frames) {
	exit;
}

// Draw enemy collision masks and the animation of those in view
var _view_left = camera_get_view_x(view_camera[0]);
var _view_top = camera_get_view_y(view_camera[0]);
var _view_right = _view_left + camera_get_view_width(view_camera[0]);
var _view_bottom = _view_top + camera_get_view_height(view_camera[0]);

with (obj_enemy) {
	if (other.show_masks) {
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
	}
	
	if (other.show_enemy_frames and point_in_rectangle(x, y, _view_left, _view_top, _view_right, _view_bottom)) {
		animation_debug_draw(x + DEV_FRAMES_OFFSET_X, y + DEV_FRAMES_OFFSET_Y);
	}
}
