function stage_setup() {
	switch (room) {
		case Test:
			set_tile_data("", 255, "collision_layer_a", "collision_layer_b");
			load_tile_data();
			break;
		default:
			set_tile_data("", 0, "", "");
			break;
	}
}