// Only one can exists
if (room == rm_pause or 
	room == rm_init_game or
	room == rm_stop_game or
	instance_number(obj_loading) > 1
) {
	instance_destroy();
	exit;
}

// Variables
depth = depths.minimum;
sprite_index = spr_loading;
x = WIDTH - 40;
y = HEIGHT - 30;
visible = true;
