function game_apply_savedata() {
	// Variables
	var _position = data_read(global.savedata, ["position"]);

	// Set parameters
	global.character = data_read(global.savedata, ["character"]);
	global.lives = data_read(global.savedata, ["life"]);
	global.checkpoint.set_hub(_position[0], _position[1]);
}
