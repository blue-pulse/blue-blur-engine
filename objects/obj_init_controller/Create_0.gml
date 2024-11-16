// Start lazy timer
game_is_loading = 60;

// Load assets in memory (Asynchronous)
audio_group_load(grp_music);
audio_group_load(grp_sfx);
audio_group_load(grp_voices);
print("[INFO] Loading assets in memory...");

// Set game parameters
randomize();
audio_channel_num(MAX_SOUNDS);
game_set_speed(MAX_FPS, gamespeed_fps);
print("[INFO] Setting initial game parameters...");

// Set screen parameters
window_set_caption(TITLE);
screen_prepare_gpu();
screen_set_properties();
print("[INFO] Screen setup was completed!");

// Create an instance of each controller
instance_create_controller(obj_core_controller);
instance_create_controller(obj_stage_controller);
print("[INFO] All controller singletons were created!");
