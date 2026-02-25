// Inherit the parent event
event_inherited();

// Parameters
bullet_speed = 1.8;
movement_dist = 80;
movement_speed = 1.5;
attack_range = movement_dist - 16;

// Variables
mask_index = sprite_index;
hspeed = movement_speed;
state = 0;
can_attack = true;
left_goal = xstart - movement_dist;
right_goal = xstart + movement_dist;

// Animations
anim_attack = animation_create(spr_buzzer_attack);
anim_fly = animation_create(spr_buzzer_fly);
anim_turn = animation_create(spr_buzzer_turn);
