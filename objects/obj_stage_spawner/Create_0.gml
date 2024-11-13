// Change depth
depth = orders.controller;

// Player
var player = instance_create_depth(x, y, orders.player, global.character);

// Camera
var camera = instance_create_depth(x, y, orders.gui, obj_camera);
camera.target = player;

// HUD
instance_create_depth(0, 0, orders.gui, obj_hud);
hud_update_visibility(true, true, true, true);
