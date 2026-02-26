// Inherit the parent event
event_inherited();

// Parameters
movement_speed = 5;

// Variables
gravity = 0.09375;
vspeed = 0;

// Animations
anim_attack = animation_create(spr_chopper_attack);
animation_play(anim_attack);
