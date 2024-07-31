// Load assets in memory (Asynchronous)
audio_group_load(grp_sfx);
audio_group_load(grp_voices);

// Set game parameters
window_set_caption(TITLE);
game_set_speed(MAX_FPS, gamespeed_fps);
