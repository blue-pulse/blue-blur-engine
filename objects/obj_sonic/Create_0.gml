// Inherit the parent event
event_inherited();

// Set collision radiuses
default_radius_x = 9;
default_radius_y = 17;
small_radius_x = 7;
small_radius_y = 12;
radius_x = default_radius_x;
radius_y = default_radius_y;

// Set spawn point
pos_x = x;
pos_y = y - radius_y - 1;

// Handle startup
sonic_states_set();
sonic_physics_params();
player_physics_hitbox();