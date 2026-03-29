// Variables
depth = depths.gui;
sprite_index = noone;
flag_layer = layer_get_id("background_1");
flag_xstart = layer_get_x(flag_layer);
flag_xend = -40;
is_loading = false;
next_room = rm_hub_world;
option_active = 0;
show_menu = true;
slot_active = db_read(global.userdata, 1, "slot");

// Menu options
options = [
    new cls_option(spr_home_button_big, WIDTH, 80, 1, "Start game"),
    new cls_option(spr_home_button_big, WIDTH, HEIGHT / 2, 0, "Settings"),
    new cls_option(spr_home_button_big, WIDTH, HEIGHT - 80, 0, "Quit"),
];
options_count = array_length(options);
options_offscreen = sprite_get_width(spr_home_button_big);
