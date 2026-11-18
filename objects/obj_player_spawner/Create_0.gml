// Variables
var _pos_x = x;
var _pos_y = y;
var _stamina = 100;
var _checkpoint = global.checkpoint;
var _gui_config = { 
	target: noone,
	show_life: true,
	show_time: false,
    show_rings: false,
    show_stamina: false,
}; 

// Get checkpoint data
if (_checkpoint.get_status()) {
	var _data = _checkpoint.get_data();
    global.time = _data[0];
    global.score = _data[1];
    _pos_x = _data[2][0];
    _pos_y = _data[2][1];
    _stamina = 0;
} else {
    global.time = 0;
    global.score = 0;
}

// Set config based on room
if (room == rm_hub_world) {
	// Set parameters
	var _data = _checkpoint.get_hub();
	_stamina = 999;
	
	// Set hub position
	if (!array_equals(_data, [0, 0])) {
		_pos_x = _data[0];
		_pos_y = _data[1];
	}
} else {
	// Set GUI config
	_gui_config.show_time = true;
    _gui_config.show_rings = true;
    _gui_config.show_stamina = true;
}

// Create player
var _player = instance_create_depth(_pos_x, _pos_y, depths.player, global.character);
_player.stamina = _stamina;
_gui_config.target = _player;

// Enable camera
instance_create_depth(_pos_x, _pos_y, depths.gui, obj_camera);
camera_set_target(_player);

// Create controllers
manager_create(obj_stage_manager);
if (REPLAY_SCENARIO != "") {
	manager_create(obj_replay_manager);
}
gui_create(obj_hud, _gui_config);
game_set_player(_player);

// Destroy spawner
instance_destroy();
