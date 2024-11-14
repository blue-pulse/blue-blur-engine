// Fonts
global.font_black = font_add_sprite_ext(spr_font_black, UNICODE, true, 0);
global.font_blue = font_add_sprite_ext(spr_font_blue, UNICODE, true, 0);
global.font_golden = font_add_sprite_ext(spr_font_golden, UNICODE, true, 0);
global.font_gray = font_add_sprite_ext(spr_font_gray, UNICODE, true, 0);
global.font_silver = font_add_sprite_ext(spr_font_silver, UNICODE, true, 0);

// Resolution parameters
global.buffer = 8;
global.fullscreen = false;

// Tiles parameters
global.tile_angles = [];
global.tile_data = [];
global.tile_heights = [];
global.tile_layers = [];
global.tile_widths = [];

// Internal parameters
global.allow_input = true;
global.character = obj_sonic;
global.debug = true;
global.game_is_paused = false;
global.lives = 3;
global.part_system = part_system_create();
global.score = 0;
