// Initialise variables
pos_x = x;
pos_y = y;
angle = 0;
rotation = 0;
accel = 0.046875;
air_accel = 0.09375;
top_accel = 6;
decel = 0.5;
roll_decel = 0.125;
frict = 0.046875;
roll_frict = 0.0234375;
jump_height = -6.5;
min_jump_height = -4;

// Set collision radiuses
default_radius_x = 9;
default_radius_y = 19;
small_radius_x = 7;
small_radius_y = 14;
radius_x = default_radius_x;
radius_y = default_radius_y;

// Set defaults
on_object = noone;
allow_collision = true;
allow_movement = true;
spindash_revolutions = -1;
gravity_force = 0.21875;
collision_mode = [0, 0];
hitbox = [0, 0];
stick_to_convex = 0;
facing = right;
state = 0;
plane = 0;

// Set flags
is_grounded	= false;
is_boosting = false;
is_rolling = false;
is_jumping = false;
is_pushing = false;
is_underwater = false;
is_being_hurt = false;

// Set states
player_set_states();

PlayerStartup();
player_handle_hitbox();
player_handle_physics();