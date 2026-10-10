// Inherit the parent event
event_inherited();

// Script
reaction_index = player_reaction_bullet;

// Variables
owner ??= noone;
impacted = false;

// SFX
mixer_play_effect(snd_bullet_shoot, REPLACE);
