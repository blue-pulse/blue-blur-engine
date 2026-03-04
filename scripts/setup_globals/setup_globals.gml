// Global parameters
global.framecount = 0;
global.time = 0;
global.is_fullscreen = false;
global.is_paused = false;
global.game_has_started = false;
global.master_volume = 1;
global.bgm_volume = 1;
global.sfx_volume = 1
global.voices_volume = 1;

// Player parameters
global.character = obj_sonic;
global.protagonist = noone;
global.lives = 3;
global.score = 0;

// Checkpoint data
global.checkpoint = {
	timecount: 0,
	scoring: 0,
	pos: [0, 0],
};
