// Get current camera position
var pos_x = camera_get_view_x(view);
var pos_y = camera_get_view_y(view);
var view_width = camera_get_view_width(view);
var view_height = camera_get_view_height(view);

// Set target camera position
var target_x = (target.x + disp_x) - view_width / 2;
var target_y = (target.y + disp_y) - view_height / 2;

// Smoothly move the camera to the target position
pos_x = lerp(pos_x, target_x, smooth_lerp);
pos_y = lerp(pos_y, target_y, smooth_lerp);

// Zoom
if (zoom_timer) {
	view_width = lerp(view_width, def_width * zoom_amount, zoom_lerp);
	view_height = lerp(view_height, def_height * zoom_amount, zoom_lerp);
	pos_x = target_x;
	pos_y = target_y;
	zoom_timer--;
} else if (view_width != def_height) {
	view_width = lerp(view_width, def_width, zoom_lerp);
	view_height = lerp(view_height, def_height, zoom_lerp);
	zoom_amount = 1;
}

// Screen shake
if (shake_timer) {
	pos_x += random_range(-shake_power, shake_power);
	pos_y += random_range(-shake_power, shake_power);
	shake_timer--;
}

// Clamp the camera to room bounds
pos_x = clamp(pos_x, 0, room_width - view_width);
pos_y = clamp(pos_y, 0, room_height - view_height);

// Apply camera position
camera_set_view_pos(view, pos_x, pos_y);
camera_set_view_size(view, view_width, view_height);
