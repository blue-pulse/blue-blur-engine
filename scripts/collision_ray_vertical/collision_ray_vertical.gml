function collision_ray_vertical(hor_offset, ver_offset, angle, object) {
	// Variables
	var pos_x = floor(x);
	var pos_y = floor(y);
	var sine = dsin(angle);
	var cosine = dcos(angle);
	
	// Setup positions
	var pos_x_1 = pos_x + (cosine * hor_offset);
	var pos_y_1 = pos_y - (sine * hor_offset);
	var pos_x_2 = pos_x + (cosine * hor_offset) + (sine * ver_offset);
	var pos_y_2 = pos_y - (sine * hor_offset) + (cosine * ver_offset);
	
	// Return collision
	return collision_line(pos_x_1, pos_y_1, pos_x_2, pos_y_2, object, true, false);
}
