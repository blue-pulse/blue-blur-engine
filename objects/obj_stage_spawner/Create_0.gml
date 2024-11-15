// Change depth
depth = queue.controller;

// Player
instance_create_depth(x, y, queue.player, global.character);

// Camera
instance_create_depth(x, y, queue.gui, obj_camera);
camera_set_target(Player);

// HUD
instance_create_depth(0, 0, queue.gui, obj_hud);
hud_update_visibility(true, true, true, true);
