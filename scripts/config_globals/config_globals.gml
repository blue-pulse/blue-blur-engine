// Global
global.framecount = 0;
global.time = 0;

// Internal
global.is_initialized = false;
global.game_is_paused = false;
global.game_state = states.init;
global.hud_is_visible = false;
global.last_played = 0;
global.last_slot = -1;
global.slot = -1;

// Sound
global.master_volume = 1;
global.bgm_volume = 1;
global.sfx_volume = 1
global.voices_volume = 1;

// Player
global.default_character = obj_sonic;
global.character = global.default_character;
global.characters = [
	obj_player,	// Adventure
	obj_player,	// Amy
	obj_player,	// Classic
	obj_player,	// Knux
	obj_player,	// Shadow
	obj_sonic,	// Sonic
	obj_player,	// Tails
	obj_player,	// Test
];
global.current_player = noone;
global.lives = DEFAULT_LIVES;
global.score = 0;

// Checkpoint data
global.checkpoint = new Checkpoint();

// Databases created by game_init_data
global.userdata = undefined;
global.savedata = undefined;
global.settings = undefined;
