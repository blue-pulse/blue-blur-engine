// Inherit the parent event
event_inherited();

// Animation
animation_setup_init();
anim_idle = animation_create(sprite_index);

// Script
reaction_index = player_reaction_enemy;

// Particles
vfx_explosion = part_type_create();
part_type_sprite(vfx_explosion, spr_enemy_explosion, true, true, false);
part_type_life(vfx_explosion, 20, 20);

// Variables
depth = depths.enemies;
animation = anim_idle;
dir = sign(image_xscale);
sfx_explosion = snd_enemy_explosion;
