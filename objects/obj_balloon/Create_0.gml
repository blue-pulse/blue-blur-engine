// Inherit the parent event
event_inherited();

// Parameters
attack_range = 120;
bullet_speed = 1.8;

// Variables
mask_index = sprite_index;
state = 0;
attack_delay = 0;
can_attack = true;

// Animations
anim_idle = animation_create(spr_balloon_idle);
anim_attack = animation_create(spr_balloon_attack);
