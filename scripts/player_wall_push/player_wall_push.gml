function player_wall_push(object, wall_dir) {
	// Early exit
	if (state != player_state_run) {
		exit;
	}
	
	// Animate
	animation_play(anim_push);
	
	// Variables
	var pos_x = dcos(angle) * wall_dir;
	var pos_y = dsin(angle) * wall_dir;

	with (object) {
	    // Abort if not pushable
	    if ((!pushable or y - yprevious != 0) or place_meeting(x + pos_x, y - pos_y, obj_solid)) {
			exit;
		}

	    // Move object
	    x += pos_x;
	    y -= pos_y;
	}

	// Move player
	x += pos_x;
	y -= pos_y;
}
