function player_init_effects() {
	// Skid dust
	vfx_skid_dust = part_type_create();
	part_type_sprite(vfx_skid_dust, spr_skid_dust, true, true, false);
	part_type_life(vfx_skid_dust, 15, 15);
	
	// Homing burst
	vfx_homing_burst = part_type_create();
	part_type_sprite(vfx_homing_burst, spr_homing_burst, true, true, false);
	part_type_life(vfx_homing_burst, 10, 10);
}
