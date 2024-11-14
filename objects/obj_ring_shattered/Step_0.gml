// Move ring
pos_x += hor_speed;
pos_y += ver_speed;
ver_speed += 0.09375;

// Check for floor
if ver_speed >= 0 {
	var find_floor = tile_find_v(pos_x, pos_y + 8, true, Player.plane)[0];
	if (find_floor < 0) {
		pos_y += find_floor;
		ver_speed *= -0.75;
	}
}

// Check for ceiling
if (ver_speed < 0) {
	var find_roof = tile_find_v(pos_x, pos_y - 8, false, Player.plane)[0];
	if (find_roof < 0) {
		ver_speed *= -0.75;
	}
}

// Check for left wall
if (hor_speed < 0) {
	var find_wall = tile_find_h(pos_x - 8, pos_y, false, Player.plane)[0];
	if (find_wall < 0) {
		hor_speed *= -0.75;
	}
}

// Check for right wall
else if (hor_speed > 0) {
	var find_wall = tile_find_h(pos_x + 8, pos_y, false, Player.plane)[0];
	if (find_wall < 0) {
		hor_speed *= -0.75;
	}
}

// Update parameters
x = floor(pos_x);
y = floor(pos_y);
instance_update_hitbox();

// Ring logic
if (--timer <= 0) {
	// Destroy when timer runs out
	instance_destroy();
} else if (timer <= 16) {
	// Disintegrate
	image_alpha -= 0.05;
} else if (timer <= timeout) {
	// Allow the player to collect the ring
	event_inherited();
}
