function camera_follow_player() {	
	// Variables
	var _target_x = floor(target.x) - (view_width / 2);
	var _target_y = floor(target.y) - (view_height / 2);
	var _target_dir = sign(target.image_xscale);
	var _target_speed = target.hor_speed;
	var _target_state = target.state;
	var _shift_direction = (_target_speed != 0) ? sign(_target_speed) : _target_dir;
	var _is_shifting_up = (_target_state == player_state_lookup);
	var _is_shifting_down = (_target_state == player_state_crouch);
	var _hor_offset = 0;
	var _ver_offset = 0;
	
	// Smoothly move the camera to the target position
	if (scroll_delay > 0) {
		scroll_delay--;
	} else {
		x = lerp(x, _target_x, smooth_lerp);
	}
	y = lerp(y, _target_y, smooth_lerp);
	
	// Offset camera horizontally depending on the speed
	if (abs(_target_speed) >= 6 or _target_state == player_state_spindash) {
		if (scroll_delay <= 0 and extended_offset != shift_value * _shift_direction) {
			extended_offset += shift_speed * _shift_direction;
		}
	} else {
		extended_offset -= shift_speed * sign(extended_offset);
	}
	
	// Check for overview delay
	if (_is_shifting_up or _is_shifting_down) {
		if (overview_delay > 0) {
			overview_delay--;
		}
	} else {
		overview_delay = 32;
	}
	
	// Offset vertically
	if (overview_delay <= 0 and (_is_shifting_up or _is_shifting_down)) {
		if (_is_shifting_up and overview_offset > -88) {
			overview_offset -= shift_speed;
		} else if (_is_shifting_down and overview_offset < 88) {
			overview_offset += shift_speed;
		}
	} else if (overview_offset != 0) {
		overview_offset -= shift_speed * sign(overview_offset);
	}

	// Set offsets
	switch (gravity_direction) {
		case 0:
			_hor_offset = extended_offset;
			_ver_offset = overview_offset;
			break;
		case 90:
			_hor_offset = -overview_offset;
			_ver_offset = extended_offset;
			break;
		case 180:
			_hor_offset = -extended_offset;
			_ver_offset = -overview_offset;
			break;
		case 270:
			_hor_offset = overview_offset;
			_ver_offset = -extended_offset;
			break;
	}
	
	// Clamp the camera to room bounds
	view_x = clamp(x + _hor_offset, 0, room_width - view_width);
	view_y = clamp(y + _ver_offset, 0, room_height - view_height);
}
