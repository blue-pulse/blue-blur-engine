// Get position
var pos_x = floor(x);
var pos_y = floor(y);

// Create objects
switch (room) {
	default:
		// Create player
		var player = instance_create_depth(pos_x, pos_y, depths.player, global.character);
		
		// Create camera
		instance_create_depth(pos_x, pos_y, depths.gui, Camera);
		camera_set_target(player);
		
		// Create stage manager
		instance_create_depth(0, 0, depths.gui, Stage);
		break;
}

// Destroy spawner
instance_destroy();
