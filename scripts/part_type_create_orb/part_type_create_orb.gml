function part_type_create_orb(color) {
	var part_orb = part_type_create();
	part_type_shape(part_orb, pt_shape_flare);
	part_type_size(part_orb, 0.18, 0.18, 0, 0);
	part_type_scale(part_orb, 3.5, 1);
	part_type_speed(part_orb, -2.5, -2.5, 0.15, 0);
	part_type_direction(part_orb, 0, 0, 0, 0);
	part_type_gravity(part_orb, 0, 270);
	part_type_orientation(part_orb, 0, 0, 0, 0, true);
	part_type_color1(part_orb, color);
	part_type_alpha2(part_orb, 0.6, 0);
	part_type_blend(part_orb, true);
	part_type_life(part_orb, 8, 8);
	return part_orb;
}
