// Global
global.framecount = 0;
global.time = 0;

// Internal
global.async_operations = [];
global.initflag = false;
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
global.checkpoint = new _cls_checkpoint();

// Databases
global.userdata = {
	slot: 1,
	wasd: true,
}

global.savedata = {
	slot: 0,
	playtime: 0,
	character: obj_sonic,
	life: 3,
	position: [0, 0],
}

global.settings = {
	graphics: { antialiasing: 2, upscaling: false, fullscreen: false },
	sounds: { bgm: 1, sfx: 1, voices: 1, },
};
