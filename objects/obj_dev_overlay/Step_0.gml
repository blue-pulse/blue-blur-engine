// Copy the player data that the panel watches
var _player = Protagonist;
if (instance_exists(_player)) {
	readout.hor_speed = _player.hor_speed;
	readout.ver_speed = _player.ver_speed;
	readout.angle = _player.angle;
	readout.mask_direction = _player.mask_direction;
	readout.gravity_direction = _player.gravity_direction;
	readout.ground_lock = _player.ground_lock;
	readout.air_lock = _player.air_lock;
	readout.plane = _player.plane;
	readout.state_previous = script_get_name(_player.state_prev);
	readout.state = script_get_name(_player.state);
	readout.sprite = sprite_get_name(_player.sprite_index);
}
