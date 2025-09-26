function collision_box(hor_offset, ver_offset, swap_axis, object) {
	// Variables
	var pos_x = floor(x);
	var pos_y = floor(y);
	
	// Setup positions
	var pos_x_1 = pos_x - hor_offset;
	var pos_y_1 = pos_y - ver_offset;
	var pos_x_2 = pos_x + hor_offset;
	var pos_y_2 = pos_y + ver_offset;
	
	// Setup positions in case the object is inverted
	if (swap_axis) {
		pos_x_1 = pos_x - ver_offset;
		pos_y_1 = pos_y - hor_offset;
		pos_x_2 = pos_x + ver_offset;
		pos_y_2 = pos_y + hor_offset;
	}
	
	// Return collision
	return collision_rectangle(pos_x_1, pos_y_1, pos_x_2, pos_y_2, object, true, false);
}
