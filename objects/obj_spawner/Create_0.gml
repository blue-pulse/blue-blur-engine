// Change depending on the stage
switch (room) {
	// Title
	case rm_title:
		break;
		
	// Hub World
	case rm_hub_world:
		// Player
		instance_create_depth(x, y, queue.player, global.character);
		player_enable_cheats();
		
		// Camera
		instance_create_depth(x, y, queue.gui, obj_camera);
		camera_set_target(Player);

		// HUD
		instance_create_depth(0, 0, queue.gui, obj_hud);
		hud_update_visibility(false, false, false, true);
		break;
		
	// Stages
	default:
		// Player
		instance_create_depth(x, y, queue.player, global.character);

		// Camera
		instance_create_depth(x, y, queue.gui, obj_camera);
		camera_set_target(Player);

		// HUD
		instance_create_depth(0, 0, queue.gui, obj_hud);
		hud_update_visibility(true, true, true, true);
		break;
}

// Destroy spawner
instance_destroy();
