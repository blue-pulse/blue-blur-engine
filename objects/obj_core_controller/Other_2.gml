// Set FPS limit
game_set_speed(global.fps_limit, gamespeed_fps);

// Load sounds
audio_group_load(grp_sfx);

// Create an instance of each controllers
controller_create(obj_stage_controller);