// Variables
var pos_x = x;
var pos_y = y;
var stamina = 100;
var checkpoint = global.checkpoint;
var gui_config = { 
	target: noone,
	show_life: true,
	show_time: false,
    show_rings: false,
    show_stamina: false,
}; 

// Get checkpoint data
if (checkpoint.get_status()) {
	var data = checkpoint.get_data();
    global.time = data[0];
    global.score = data[1];
    pos_x = data[2][0];
    pos_y = data[2][1];
    stamina = 0;
} else {
    global.time = 0;
    global.score = 0;
}

// Set config based on room
if (room == rm_hub_world) {
	// Set parameters
	var data = checkpoint.get_hub();
	stamina = 999;
	
	// Set hub position
	if (!array_equals(data, [0, 0])) {
		pos_x = data[0];
		pos_y = data[1];
	}
} else {
	// Set GUI config
	gui_config.show_time = true;
    gui_config.show_rings = true;
    gui_config.show_stamina = true;
}

// Create player
var player = instance_create_depth(pos_x, pos_y, depths.player, global.character);
player.stamina = stamina;
gui_config.target = player;

// Enable camera
instance_create_depth(pos_x, pos_y, depths.gui, Camera);
camera_set_target(player);

// Create controllers
manager_create(Stage);
gui_create(obj_hud, gui_config);
Protagonist = player;

// Destroy spawner
instance_destroy();
