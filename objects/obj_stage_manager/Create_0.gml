// Variables
name = "None";
desc = "None";
bgm_sound = noone;
bgm_loop_start = 0;
bgm_loop_end = 0;
reset_timer = 0;

// Set stage data
init_stage_data();

// Set culling interval
alarm_set(0, CULL_FREQ);
