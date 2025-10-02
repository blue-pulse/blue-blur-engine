// Early exit
if (!enabled or !instance_exists(target)) {
	exit;
}

// Follow target
if (target == Player) {
	camera_follow_player();
} else {
	// Set target camera position
	target_x = target.x - view_width / 2;
	target_y = target.y - view_height / 2;
	
	// Smoothly move the camera to the target position
	x = lerp(x, target_x, smooth_lerp);
	y = lerp(y, target_y, smooth_lerp);
	
	// Clamp the camera to room bounds
	view_x = clamp(x, 0, room_width - view_width);
	view_y = clamp(y, 0, room_height - view_height);
}

// Screen shake
if (shake_timer) {
	view_x += random_range(-shake_power, shake_power);
	view_y += random_range(-shake_power, shake_power);
	if (shake_timer != infinity) then shake_timer--;
}

// Zoom
if (zoom_timer) {
	view_width = lerp(view_width, WIDTH * zoom_amount, zoom_lerp);
	view_height = lerp(view_height, HEIGHT * zoom_amount, zoom_lerp);
	if (zoom_timer != infinity) then zoom_timer--;
} else if (view_width != HEIGHT) {
	camera_restore_zoom();
}

// Apply camera position
camera_set_view_pos(View, view_x, view_y);
camera_set_view_size(View, floor(view_width), floor(view_height));
