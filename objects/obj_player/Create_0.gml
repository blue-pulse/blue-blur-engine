// Initialise physics variables
pos_x = x;
pos_y = y;
angle = 0;
rotation = 360;
opacity = 1;
accel = 0;
air_accel = 0;
top_speed = 0;
decel = 0;
roll_decel = 0;
frict = 0;
roll_frict = 0;
jump_height = 0;
min_jump_height = 0;
ground_speed = 0;
horizontal_speed = 0;
vertical_speed = 0;

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
facing = RIGHT;
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
forced_roll = false;
ground_lock = false;
air_lock = false;

// Set global variables
score = global.player_score;
lives = global.player_lives;

// Player startup
player_hitbox_update();