function camera_follow_player() {
	// Set target camera position
	target_x = floor(target.x) - (view_width / 2);
	target_y = floor(target.y) - (view_height / 2);
	
	// Smoothly move the camera to the target position
	if (scroll_delay) {
		scroll_delay--;
	} else {
		x = lerp(x, target_x, smooth_lerp);
	}
	y = lerp(y, target_y, smooth_lerp);
	
	// Offset camera horizontally depending on the speed
	var shift_direction = (target.hor_speed != 0) ? sign(target.hor_speed) : target.dir;
	if (abs(target.hor_speed) >= 6 or target.state == player_is_spindashing) {
		if (!scroll_delay and extended_offset != shift_value * shift_direction) {
			extended_offset += shift_speed * shift_direction;
		}
	} else {
		extended_offset -= shift_speed * sign(extended_offset);
	}
	
	// Check for overview delay
	var shift_up = (target.state == player_is_looking);
	var shift_down = (target.state == player_is_crouching);
	
	if (shift_up or shift_down) {
		if (overview_delay) {
			overview_delay--;
		}
	} else {
		overview_delay = 96;
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
	view_x = clamp(x + extended_offset, 0, room_width - view_width);
	view_y = clamp(y + overview_offset, 0, room_height - view_height);
}
