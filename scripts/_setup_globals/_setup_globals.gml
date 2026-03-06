// Global
global.framecount = 0;
global.time = 0;

// Internal
global.allow_upscaling = false;
global.fullscreen = false;
global.game_has_started = false;
global.game_is_paused = false;
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
global.character = obj_sonic;
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
global.protagonist = noone;
global.lives = 3;
global.score = 0;

// Checkpoint data
global.checkpoint = {
	timecount: 0,
	scoring: 0,
	room_pos: [0, 0],
	hub_pos: [0, 0],
};
