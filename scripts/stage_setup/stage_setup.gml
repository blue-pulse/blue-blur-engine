function stage_setup() {
	switch (room) {
		case rm_test_zone:
			tile_set_data("", 255, "collision_layer_a", "collision_layer_b");
			tile_load_data();
			break;
		default:
			tile_set_data(noone, 0, "", "");
			break;
	}
}