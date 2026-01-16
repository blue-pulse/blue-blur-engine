// Inherit the parent event
event_inherited();

// Parameters
fly_speed = 1.5;
bullet_speed = 1.8;
movement_dist = 80;
attack_range = movement_dist - 16;

// Variables
mask_index = sprite_index;
hspeed = fly_speed;
state = 0;
can_attack = true;
left_goal = xstart - movement_dist;
right_goal = xstart + movement_dist;

// Animations
anim_attack = animation_create(spr_stinger_attack);
anim_fly = animation_create(spr_stinger_fly);
anim_turn = animation_create(spr_stinger_turn);
