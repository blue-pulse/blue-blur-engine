// Start package
show_debug_message("EasyAudio: Welcome to EasyAudio by Blue Pulse!");

// Settings
show_debug_message("EasyAudio: Initializing settings...");
enum ESAU_MODES { OVERLAP = 0, SINGLE = 1, SWAP = 2 };
enum ESAU_PRIORITIES { BGM = 100, SFX = 1, VOICES = 2  };

// Config
show_debug_message("EasyAudio: Reading config...");
_easyaudio_config();

// Load groups in memory (Asynchronous)
show_debug_message("EasyAudio: Loading audio groups in memory...");
audio_group_load(ESAU_GROUP_BGM);
audio_group_load(ESAU_GROUP_SFX);
audio_group_load(ESAU_GROUP_VOICES);
