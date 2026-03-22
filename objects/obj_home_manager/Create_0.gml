// Variables
depth = depths.gui;
sprite_index = noone;
next_room = rm_hub_world;
is_loading = false;
ui_layer = layer_get_id("ui_main");

// Set slot index
selected_slot = db_read(global.userdata, 1, "slot");

// Menu options
options = [
    new cls_option(spr_home_button_big, WIDTH, 80, "Start game"),
    new cls_option(spr_home_button_big, WIDTH, HEIGHT / 2, "Settings"),
    new cls_option(spr_home_button_big, WIDTH, HEIGHT - 80, "Quit"),
];
options_length = array_length(options);
