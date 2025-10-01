// Fonts
global.font_hud = font_add_sprite(sprFontHUD, ord("0"), false, 1);
global.font_lives = font_add_sprite(sprFontLives, ord("0"), false, 0);
global.font_title = font_add_sprite(sprFontTitle, ord("A"), true, 0);
global.font_debug = font_add_sprite(sprFontDebug, ord("!"), false, 1);

// Particle system
global.particles = part_system_create();

// Ring sparkle
global.ring_sparkle = part_type_create();
part_type_sprite(global.ring_sparkle, sprRingSparkle, true, true, false);
part_type_life(global.ring_sparkle, 24, 24);

// Brake dust
global.brake_dust = part_type_create();
part_type_sprite(global.brake_dust, sprBrakeDust, true, true, false);
part_type_life(global.brake_dust, 16, 16);

// Explosion
global.explosion = part_type_create();
part_type_sprite(global.explosion, sprExplosion, true, true, false);
part_type_life(global.explosion, 30, 30);

// Motobug smoke
global.motobug_smoke = part_type_create();
part_type_sprite(global.motobug_smoke, sprMotobugSmoke, true, true, false);
part_type_life(global.motobug_smoke, 16, 16);

// Homing burst
global.homing_burst = part_type_create();
part_type_sprite(global.homing_burst, sprHomingBurst, true, true, false);
part_type_life(global.homing_burst, 10, 10);