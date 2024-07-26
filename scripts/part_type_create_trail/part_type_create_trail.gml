function part_type_create_trail(color) {
	var par_trail = part_type_create();
	part_type_shape(par_trail, pt_shape_flare);
	part_type_size(par_trail, 0.18, 0.18, 0, 0);
	part_type_scale(par_trail, 5.8, 2);
	part_type_speed(par_trail, -2.5, -2.5, 0.15, 0);
	part_type_direction(par_trail, 0, 0, 0, 0);
	part_type_gravity(par_trail, 0, 270);
	part_type_orientation(par_trail, 0, 0, 0, 0, true);
	part_type_color1(par_trail, color);
	part_type_alpha2(par_trail, 0.6, 0);
	part_type_blend(par_trail, true);
	part_type_life(par_trail, 12, 12);
	return par_trail;
}