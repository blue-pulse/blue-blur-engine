// Variables
allow_gameplay = false;
allow_culling = false;
bgm_loop_end = 0;
bgm_loop_start = 0;
bgm_sound = noone;
desc = "None";
name = "None";

// Set stage data
stage_bootstrap();
stage_init_data();

// Set culling interval
if (allow_culling) {
	alarm_set(0, cull.freq);
}
