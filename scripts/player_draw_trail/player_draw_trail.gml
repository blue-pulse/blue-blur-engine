function player_draw_trail(allow_spark=false) {
	// Variables
	static afterimage_counter = 0;
	
	// Draw afterimage
	afterimage_counter++;
	if (allow_spark and afterimage_counter == 6) {
		instance_create_vfx(prev_pos_x, prev_pos_y, obj_boost_spark, true);
	} else if (afterimage_counter >= 7) {
		afterimage_counter = 0;
		instance_create_vfx(prev_pos_x, prev_pos_y, obj_afterimage, true);
	}
	
	// Draw particles
	var trail_angle = point_direction(prev_pos_x, prev_pos_y, pos_x, pos_y);
	part_type_direction(ast_boost.par_trail, trail_angle, trail_angle, 0, 0);
	part_particles_create(part_sys, x, y, ast_boost.par_trail, 2);
}