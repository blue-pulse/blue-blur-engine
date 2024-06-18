// Initialise variables
pos_x = x;
pos_y = y;
accel = 0;
decel = 0;
angle = 0;
visual_angle = 0;
horizontal_speed = 0;
vertical_speed = 0;
ground_speed = 0;

facing = 1;
current_layer = 0;
default_radius = [9, 19];
small_radius = [7, 14];
radius_x = default_radius[0];
radius_y = default_radius[1];

on_object = false;
is_pushing = false;
is_spinning = false;
is_grounded = false;
is_underwater = false;
allow_collision	= true;
allow_movement = true;

collision_mode = [0, 0];
gravity_force = 0.21875;
stick_to_convex = false;

// Load score and lives
current_score = global.player_score;
current_lives = global.player_lives;

// State machine
set_player_state_machine();
set_player_states();