// Early exit
if (!enabled or !instance_exists(target)) {
	return;
}

// Variables
var half_width = view_width / 2;
var half_height = view_height / 2;

// Follow player
if (target == Player) {
	// Set target camera position
	target_x = floor(target.pos_x) - half_width;
	target_y = floor(target.pos_y) - half_height;
	
	// Smoothly move the camera to the target position
	if (scroll_delay) {
		scroll_delay--;
	} else {
		pos_x = lerp(pos_x, target_x, smooth_lerp);
	}
	pos_y = lerp(pos_y, target_y, smooth_lerp);
	
	// Offset camera horizontally depending on the speed
	var shift_direction = (target.gnd_speed != 0) ? sign(target.gnd_speed) : target.dir;
	if (abs(target.gnd_speed) >= 6 or target.state == states.spindash) {
		if (!scroll_delay and extended_offset != shift_value * shift_direction) {
			extended_offset += shift_speed * shift_direction;
		}
	} else {
		extended_offset -= shift_speed * sign(extended_offset);
	}
	
	// Check for overview delay
	var shift_up = (target.state == states.searching);
	var shift_down = (target.state == states.crouching);
	
	if (shift_up or shift_down) {
		if (overview_delay) {
			overview_delay--;
		}
	} else {
		overview_delay = 120;
	}
	
	// Offset vertically
	if (!overview_delay and (shift_up or shift_down)) {
		if (shift_up and overview_offset > -88) {
			overview_offset -= shift_speed;
		} else if (shift_down and overview_offset < 88) {
			overview_offset += shift_speed;
		}
	} else if (overview_offset != 0) {
		overview_offset -= shift_speed * sign(overview_offset);
	}
	
	// Clamp the camera to room bounds
	view_x = clamp(pos_x + extended_offset, 0, room_width - view_width);
	view_y = clamp(pos_y + overview_offset, 0, room_height - view_height);
}

// Follow any other object
else {
	// Set target camera position
	target_x = target.x - half_width;
	target_y = target.y - half_height;
	
	// Smoothly move the camera to the target position
	pos_x = lerp(pos_x, target_x, smooth_lerp);
	pos_y = lerp(pos_y, target_y, smooth_lerp);
	
	// Clamp the camera to room bounds
	view_x = clamp(pos_x, 0, room_width - view_width);
	view_y = clamp(pos_y, 0, room_height - view_height);
}

// Screen shake
if (shake_timer) {
	view_x += random_range(-shake_power, shake_power);
	view_y += random_range(-shake_power, shake_power);
	shake_timer--;
}

// Zoom
if (zoom_timer) {
	view_width = lerp(view_width, WIDTH * zoom_amount, zoom_lerp);
	view_height = lerp(view_height, HEIGHT * zoom_amount, zoom_lerp);
	zoom_timer--;
} else if (view_width != HEIGHT) {
	view_width = lerp(view_width, WIDTH, zoom_lerp);
	view_height = lerp(view_height, HEIGHT, zoom_lerp);
	zoom_amount = 1;
}

// Apply camera position
camera_set_view_pos(Camera, view_x, view_y);
camera_set_view_size(Camera, floor(view_width), floor(view_height));
