// Fonts
global.font_debug = font_add_sprite(sprFontDebug, ord("!"), false, 1);

// Particle system
global.particles = part_system_create();

// Ring sparkle
global.ring_sparkle = part_type_create();
part_type_sprite(global.ring_sparkle, spr_ring_sparkle, true, true, false);
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

function start_engine() {
	surface_depth_disable(true);
	randomize();

	// Screen / camera macros
	#macro SCREEN_WIDTH 400
	#macro SCREEN_HEIGHT 224
	#macro CAMERA_ID view_camera[0]
	#macro CAMERA_PADDING 64

	// Reaction macros
	#macro DIR_LEFT -1
	#macro DIR_RIGHT 1
	#macro DIR_TOP -2
	#macro DIR_BOTTOM 2
	
	// Start game
	room_fadeto(rm_test_zone);
}
