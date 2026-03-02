// Variables
var pos_x = 0;
var pos_y = 0;

// Set checkpoint data
if (global.checkpoint.timecount) {
	global.time = global.checkpoint.timecount;
	global.score = global.checkpoint.scoring;
	pos_x = global.checkpoint.pos[0];
	pos_y = global.checkpoint.pos[1];
} 

// Set initial data
else {
	global.time = 0;
	global.score = 0;
	pos_x = x;
	pos_y = y;
}

// Create objects
switch (room) {
	default:
		// Create player
		Protagonist = instance_create_depth(pos_x, pos_y, depths.player, global.character);
		
		// Create camera
		instance_create_depth(pos_x, pos_y, depths.gui, Camera);
		camera_set_target(Protagonist);
		
		// Create managers
		manager_create(Stage);
		
		// HUD
		instance_create_depth(0, 0, depths.gui, obj_hud, {
			target: Protagonist,
			show_time: true,
			show_rings: true,
			show_life: true,
			show_stamina: true,
		});
		break;
}

// Destroy spawner
instance_destroy();
