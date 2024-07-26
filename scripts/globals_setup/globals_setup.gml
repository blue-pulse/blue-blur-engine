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

// Particle system
global.part_system = part_system_create();

// Set player parameters
global.player_score = 0;
global.player_lives = 3;
global.current_character = obj_sonic;

// Set game parameters
global.debug = true;
global.game_is_paused = false;
