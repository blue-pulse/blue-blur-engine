// Inherit the parent event
event_inherited();

// Script
reaction_index = player_reaction_badnik;

// Particles
vfx_explosion = part_type_create();
part_type_sprite(vfx_explosion, spr_enemy_explosion, true, true, false);
part_type_life(vfx_explosion, 20, 20);

// Variables
depth = depths.enemies;
sfx_explosion = snd_enemy_explosion;
