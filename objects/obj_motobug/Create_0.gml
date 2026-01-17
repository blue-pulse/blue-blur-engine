// Inherit the parent event
event_inherited();

// Parameters
accel = 1;

// Variables
hspeed = 1;

// Animations
anim_attack = animation_create(spr_motobug_attack);
anim_turn = animation_create(spr_motobug_turn);
animation_play(anim_attack);
