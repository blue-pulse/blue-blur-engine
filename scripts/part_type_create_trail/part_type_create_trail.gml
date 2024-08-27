function part_type_create_trail(color) {
	var par_trail = part_type_create();
	part_type_shape(par_trail, pt_shape_sphere);
	part_type_size(par_trail, 0.2, 0.2, 0, 0);
	part_type_scale(par_trail, 6, 2);
	part_type_speed(par_trail, -2.5, -2.5, 0.15, 0);
	part_type_direction(par_trail, 0, 0, 0, 0);
	part_type_orientation(par_trail, 0, 0, 0, 0, true);
	part_type_color1(par_trail, color);
	part_type_alpha3(par_trail, 0.8, 0.25, 0);
	part_type_blend(par_trail, true);
	part_type_life(par_trail, 10, 10);
	return par_trail;
}