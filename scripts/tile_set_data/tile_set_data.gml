function tile_set_data(name, tile_amount, layer_a, layer_b) {
	if (name != noone) {
		global.tile_data = [name, tile_amount];
		global.tile_layers = [
			layer_tilemap_get_id(layer_a),
			layer_tilemap_get_id(layer_b),
			layer_a,
			layer_b
		];
	} else {
		global.tile_data = [];
		global.tile_layers = [];
	}
}
