// Fonts
global.font_hud_black = font_add_sprite_ext(spr_font_black, UNICODE, true, 0);
global.font_hud_blue = font_add_sprite_ext(spr_font_blue, UNICODE, true, 0);
global.font_hud_golden = font_add_sprite_ext(spr_font_golden, UNICODE, true, 0);
global.font_hud_gray = font_add_sprite_ext(spr_font_gray, UNICODE, true, 0);
global.font_hud_silver = font_add_sprite_ext(spr_font_silver, UNICODE, true, 0);

// Global parameters
global.framecount = 0;
global.is_fullscreen = false;
global.is_paused = false;

// Player parameters
global.character = obj_sonic;
global.checkpoint_data = [];
global.lives = 3;
global.score = 0;
