// Variables
var pos_x = x;
var pos_y = y;
var stamina = 100;
var checkpoint_data = global.checkpoint;
var gui_config = { 
	target: noone,
	show_life: true,
	show_time: false,
    show_rings: false,
    show_stamina: false,
}; 

// Get checkpoint data
if (checkpoint_data.timecount) {
    global.time = checkpoint_data.timecount;
    global.score = checkpoint_data.scoring;
    pos_x = checkpoint_data.room_pos[0];
    pos_y = checkpoint_data.room_pos[1];
    stamina = 0;
} else {
    global.time = 0;
    global.score = 0;
}

// Set config based on room
if (room == rm_hub_world) {
	// Set parameters
	var hub_position = checkpoint_data.hub_pos;
	stamina = 999;
	
	// Set hub position
	if (!array_equals(hub_position, [0, 0])) {
		pos_x = hub_position[0];
		pos_y = hub_position[1];
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
