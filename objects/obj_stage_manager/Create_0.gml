// Variables
allow_culling = true;
bgm_loop_end = 0;
bgm_loop_start = 0;
bgm_sound = noone;
desc = "None";
name = "None";
reset_timer = 0;

// Set stage data
init_stage_data();

// Set culling interval
if (allow_culling) {
	alarm_set(0, CULL_FREQ);
}
