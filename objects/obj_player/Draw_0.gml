// Update angle
if (array_contains(rotation_allowed_states, state)) {
	image_angle = rotation;
} else {
	image_angle = gravity_direction;
}

// Update direction
if (!array_contains(direction_denied_states, state)) {
	image_xscale = dir;
}

// Update visibility
image_alpha = alpha;

// Character sprite
player_draw_trail(c_blue);
draw_object();
