// Inherit the parent event
event_inherited();

// Set variables
pos_x = x;
pos_y = y;
hor_speed = 1;
ver_speed = 0;
state = states.fall;
timer = 0;
instance_set_hitbox(20, 17);
