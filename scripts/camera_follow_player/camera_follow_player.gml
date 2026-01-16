function camera_follow_player() {
	// Variables
	var target_x = floor(target.x) - (view_width / 2);
	var target_y = floor(target.y) - (view_height / 2);
	var target_dir = sign(target.image_xscale);
	var target_speed = target.hor_speed;
	var target_state = target.state;
	var shift_direction = (target_speed != 0) ? sign(target_speed) : target_dir;
	var shift_up = (target_state == player_state_lookup);
	var shift_down = (target_state == player_state_crouch);
	
	// Smoothly move the camera to the target position
	if (scroll_delay) {
		scroll_delay--;
	} else {
		x = lerp(x, target_x, smooth_lerp);
	}
	y = lerp(y, target_y, smooth_lerp);
	
	// Offset camera horizontally depending on the speed
	if (abs(target_speed) >= 6 or target_state == player_state_spindash) {
		if (!scroll_delay and extended_offset != shift_value * shift_direction) {
			extended_offset += shift_speed * shift_direction;
		}
	} else {
		extended_offset -= shift_speed * sign(extended_offset);
	}
	
	// Check for overview delay
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
