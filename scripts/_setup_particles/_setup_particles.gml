// Particle system
global.particles = part_system_create();
part_system_depth(global.particles, depths.effects);

// Big explosion
global.vfx_big_explosion = part_type_create();
part_type_sprite(global.vfx_big_explosion, spr_big_explosion, true, true, false);
part_type_life(global.vfx_big_explosion, 20, 20);

// Small explosion
global.vfx_small_explosion = part_type_create();
part_type_sprite(global.vfx_small_explosion, spr_small_explosion, true, true, false);
part_type_life(global.vfx_small_explosion, 15, 15);
