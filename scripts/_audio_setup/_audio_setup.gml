// Start package
show_debug_message("EasyAudio: Welcome to EasyAudio by Blue Pulse!");

// Macros
show_debug_message("EasyAudio: Initializing macros...");
#macro PRIORITY_BGM 100
#macro PRIORITY_SFX 1
#macro PRIORITY_SPEECH 2

// Config
show_debug_message("EasyAudio: Reading config...");
_audio_config();

// Load groups in memory (Asynchronous)
show_debug_message("EasyAudio: Loading audio groups in memory...");
audio_group_load(GROUP_BGM);
audio_group_load(GROUP_SFX);
audio_group_load(GROUP_SPEECH);
