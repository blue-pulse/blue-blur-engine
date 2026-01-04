function player_init_effects() {
	// Skid dust
	skid_dust = part_type_create();
	part_type_sprite(skid_dust, spr_skid_dust, true, true, false);
	part_type_life(skid_dust, 15, 15);
}
