// Change depth
depth = queue.controller;

// Player
var player = instance_create_depth(x, y, queue.player, global.character);

// Camera
var camera = instance_create_depth(x, y, queue.gui, obj_camera);
camera.target = player;

// HUD
instance_create_depth(0, 0, queue.gui, obj_hud);
hud_update_visibility(true, true, true, true);
