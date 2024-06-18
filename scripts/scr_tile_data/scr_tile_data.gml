function set_tile_data(file_name, amount_tiles, tiles_layer_a, tiles_layer_b) {
	if (amount_tiles != 0) {
		global.tile_data   = [file_name, amount_tiles];
		global.tile_layers = [layer_tilemap_get_id(tiles_layer_a), layer_tilemap_get_id(tiles_layer_b), tiles_layer_a, tiles_layer_b];
	} else {
		global.tile_data   = [];
		global.tile_layers = [];
	}
}

function load_tile_data() {
	// Clear tiledata
	global.tile_angles	= [];
	global.tile_heights = [];
	global.tile_widths	= [];

	// Set variables
	var tile_name = global.tile_data[0];
	var data_files = [
		"anglemap"  + tile_name + ".bin",
		"heightmap" + tile_name + ".bin",
		"widthmap"  + tile_name + ".bin"
	];

	// Load binary files
	for (var i = 0; i < 3; i++) {
		// Load data file
		var file_name = data_files[i];
		var file = file_bin_open("config/tiledata/" + file_name, 0);	

		// Obtain file data
		if (file != noone) {
			var file_size = file_bin_size(file);
			
			for (var j = 0; j <= global.tile_data[1]; j++) {
				switch (i) {
					// Load angle map
					case 0:	
						global.tile_angles[j] = j < file_size ? (256 - file_bin_read_byte(file)) * 360 / 256 : 0;
						break;
					// Load heigh tmap
					case 1:
						for (var k = 0; k < 16; k++) {
							global.tile_heights[j][k] = (j * 16 < file_size) ? file_bin_read_byte(file) : 0;
						}
						break;
					// Load width map
					case 2:
						for (var l = 0; l < 16; l++) {
							global.tile_widths[j][l] = (j * 16 < file_size) ? file_bin_read_byte(file) : 0;	 
						}
						break;
				}
			}
		
			// Close file
			file_bin_close(file);
		}
	}
}
