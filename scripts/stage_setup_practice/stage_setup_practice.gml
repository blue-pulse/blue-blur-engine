function stage_setup_practice() {
	// Load collision tiles
	tile_set_data("", 255, "collision_a", "collision_b");
	tile_load_data();
	
	// Setup stage music
	audio_play_bgm(snd_tidal_tempest, 56.56, 188.36);
}