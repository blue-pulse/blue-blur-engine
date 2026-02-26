// Inherit the parent event
event_inherited();

// Script
reaction_index = player_reaction_ring;

// Particles
vfx_sparkle = part_type_create();
part_type_sprite(vfx_sparkle, spr_ring_sparkle, true, true, false);
part_type_life(vfx_sparkle, 24, 24);

// Variables
depth = depths.backstage;
amount = 1;
anim_speed = room_speed / sprite_get_speed(sprite_index);
sound_fx = [snd_ring_left, snd_ring_right];
