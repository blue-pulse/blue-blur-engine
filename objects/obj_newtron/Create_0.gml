// Inherit the parent event
event_inherited();

// Parameters
attack_range = 96;
bullet_speed = 3;
fade_in_steps = 12;
attack_steps = 60;
fire_at_step = 30;
fade_out_steps = 12;

// Variables
mask_index = sprite_index;
visible = false;
state = newtron_states.wait;
state_timer = 0;

// Animations
newtron_init_animations();
