// Variables
depth = depths.gui;
sprite_index = noone;
in_process = false;
option_active = 0;
pause_surface = noone;
paused_room = noone;
pos_x = WIDTH / 2;
pos_y = HEIGHT / 2;
scale_x = WIDTH / surface_get_width(application_surface);
scale_y = HEIGHT / surface_get_height(application_surface);

// Menu options
options = [
    new cls_option(spr_pause_resume, pos_x, pos_y, 1),
    new cls_option(spr_pause_restart, pos_x, pos_y, 0),
    new cls_option(spr_pause_exit, pos_x, pos_y, 0),
];
options_count = array_length(options);
