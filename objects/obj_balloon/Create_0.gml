// Inherit the parent event
event_inherited();

// Parameters
attack_range = 120;
bullet_speed = 1.8;
attack_steps = 36;
fire_at_step = 30;

// Variables
mask_index = sprite_index;
state = balloon_states.idle;
state_timer = 0;
can_attack = true;
attack_delay = 0;

// Animations
balloon_init_animations();
