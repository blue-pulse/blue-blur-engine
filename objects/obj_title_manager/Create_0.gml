// Variables
depth = depths.gui;
sprite_index = noone;

// Logo
logo_x = WIDTH / 2;
logo_y = (HEIGHT / 2) - 12;
logo_scale = 0.08;

// Press start
start_message_x = 244;
start_message_y = 222;

// Temp
instance_create_depth(start_message_x, start_message_y, depths.gui, obj_press_start);
global.slot = 10;
game_load_save();

