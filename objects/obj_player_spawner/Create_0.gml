// Get position
var pos_x = floor(x);
var pos_y = floor(y);

// Create objects
switch (room) {
	default:
		// Create player
		var player = instance_create_depth(pos_x, pos_y, queue.player, global.character);
		
		// Create camera
		instance_create_depth(pos_x, pos_y, queue.gui, Camera);
		camera_set_target(player);
		break;
}

// Destroy spawner
instance_destroy();
