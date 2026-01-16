// Inherit the parent event
event_inherited();

// Variables
hspeed = 1.5;
can_shoot = true;
movement_dist = 80;
turn_wait = 0;
state = "fly";
is_attacking = false;

// Animations
anim_fly = animation_create(spr_stinger_fly);
anim_shoot = animation_create(spr_stinger_shoot);
anim_turn = animation_create(spr_stinger_turn);
animation_set_successor(anim_turn, anim_fly);
//animation_set_successor(anim_shoot, anim_fly);
