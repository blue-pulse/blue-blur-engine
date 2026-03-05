// Variables
depth = depths.gui;
sprite_index = noone;
paused_room = noone;
options = [];
options_length = 0
in_process = false;
pause_surface = noone;
pos_x = WIDTH / 2;
pos_y = HEIGHT / 2;
scale_x = WIDTH / surface_get_width(application_surface);
scale_y = HEIGHT / surface_get_height(application_surface);
selected_option = 0;

// Menu options
options = [
    new cls_option(spr_pause_resume),	// 0
    new cls_option(spr_pause_restart),	// 1
    new cls_option(spr_pause_exit),		// 2
];
options_length = array_length(options);
