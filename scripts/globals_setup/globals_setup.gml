// Set resolution parameters
global.width = 400;
global.height = 224;
global.buffer = 8;

// Set window parameters
global.size = 2;
global.fullscreen = false;

// Set input parameters
global.allow_input = true;

// Set tiles parameters
global.tile_data = [];
global.tile_layers = [];
global.tile_angles = [];
global.tile_widths = [];
global.tile_heights = [];

// Set internal parameters
global.debug = true;
global.game_is_paused = false;
global.part_system = part_system_create();
global.player_score = 0;
global.player_lives = 3;
global.player_character = obj_sonic;
