function dev_run_command(_command) {
	// Game commands
	if (!_command.needs_player) {
		_command.run();
		exit;
	}
	
	// Early exit
	var _player = Protagonist;
	if (!instance_exists(_player) or _player.state == player_state_death) {
		exit;
	}
	
	// Player commands
	_command.run(_player);
}
