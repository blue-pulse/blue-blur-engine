// Inherit the parent event
event_inherited();

// Parameters
bullet_speed = 1.8;
movement_dist = 80;
movement_speed = 1.5;
attack_range = movement_dist - 16;
turn_steps = 4;
attack_steps = 56;
fire_at_step = 32;

// Variables
mask_index = sprite_index;
hspeed = movement_speed;
state = buzzer_states.fly;
state_timer = 0;
can_attack = true;
left_goal = xstart - movement_dist;
right_goal = xstart + movement_dist;

// Animations
buzzer_init_animations();
