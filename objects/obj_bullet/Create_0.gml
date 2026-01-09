// Inherit the parent event
event_inherited();

// Script
reaction_index = player_reaction_bullet;

// Variables
impacted = false;
owner ??= noone;

// Particles
vfx_explosion = part_type_create();
part_type_sprite(vfx_explosion, spr_bullet_explosion, true, true, false);
part_type_life(vfx_explosion, 15, 15);

// SFX
audio_play_sfx(snd_bullet_shoot);
