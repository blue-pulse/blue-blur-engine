function dev_run_command(_command) {
	// Game commands
	if (!_command.is_player_required) {
		_command.run();
		exit;
	}
	
	// Early exit
	var _player = game_get_player();
	if (!instance_exists(_player) or _player.state == player_state_death) {
		exit;
	}
	
	// Player commands
	_command.run(_player);
}
