/// @description Initialize custom resources
image_speed = 0;

// Fonts
font_hud = font_add_sprite(sprFontHUD, ord("0"), false, 1);
font_lives = font_add_sprite(sprFontLives, ord("0"), false, 0);
font_title = font_add_sprite(sprFontTitle, ord("A"), true, 0);
font_debug = font_add_sprite(sprFontDebug, ord("!"), false, 1);

// Particle system
particles = part_system_create();

// Ring sparkle
ring_sparkle = part_type_create();
part_type_sprite(ring_sparkle, sprRingSparkle, true, true, false);
part_type_life(ring_sparkle, 24, 24);

// Brake dust
brake_dust = part_type_create();
part_type_sprite(brake_dust, sprBrakeDust, true, true, false);
part_type_life(brake_dust, 16, 16);

// Explosion
explosion = part_type_create();
part_type_sprite(explosion, sprExplosion, true, true, false);
part_type_life(explosion, 30, 30);

// Motobug smoke
motobug_smoke = part_type_create();
part_type_sprite(motobug_smoke, sprMotobugSmoke, true, true, false);
part_type_life(motobug_smoke, 16, 16);

// Homing burst
homing_burst = part_type_create();
part_type_sprite(homing_burst, sprHomingBurst, true, true, false);
part_type_life(homing_burst, 10, 10);