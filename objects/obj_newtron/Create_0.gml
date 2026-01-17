// Inherit the parent event
event_inherited();

// Parameters
attack_range = 96;
bullet_speed = 3;

// Variables
visible = false;
state = 0;
attack_delay = 0;

// Animations
anim_attack = animation_create(spr_newtron_attack);
anim_fadein = animation_create(spr_newtron_idle);
anim_fadeout = animation_create(spr_newtron_idle, -1);
