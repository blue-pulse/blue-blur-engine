// Inherit the parent event
event_inherited();

// Parameters
movement_speed = 5;

// Variables
mask_index = sprite_index;
gravity = 0.09375;
vspeed = 0;
state = chopper_states.fly;

// Animations
chopper_init_animations();
