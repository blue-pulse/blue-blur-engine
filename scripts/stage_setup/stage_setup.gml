function stage_setup() {
	switch (room) {
		case rm_practice_zone:
			tile_set_data("", 255, "collision_layer_a", "collision_layer_b");
			tile_load_data();
			audio_play_bgm(snd_tidal_tempest, 56.56, 188.36);
			break;
		default:
			tile_set_data(noone, 0, "", "");
			break;
	}
}
