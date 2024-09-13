// Change depth
depth = orders.controller;

// Create player
instance_create_depth(x, y, orders.player, global.current_character);
instance_create_depth(0, 0, orders.gui, obj_hud);
