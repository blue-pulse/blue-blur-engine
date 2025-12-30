// Basic variables
depth = queue.player;
animation = noone;
rings = 0;
score_combo = 0;
scoring = global.score;

// Position variables
angle = 0;
alpha = 1;
rotation = 360;

// State flags
allow_jump_action = false;
allow_movement = true;
invincibility_fx = noone;
is_jumping = false;
is_rolling = false;
is_underwater = false;
spindash_charge = 0;
spindash_pitch = 1;
state = player_state_init;
state_prev = state;

// State arrays
direction_denied_states = [
	player_state_airbone,
	player_state_roll,
];
hurt_denied_state = [
	player_state_death, 
	player_state_hurt,
	player_state_init,
	player_state_knockout,
];
rotation_allowed_states = [
	player_state_airbone,
	player_state_roll,
	player_state_run,
	player_state_skid,
	player_state_knockout
];

// Movement
dir = sign(image_xscale);
cliff_dir = 0;
hor_speed = 0;
ver_speed = 0;
speed_cap = 16;
plane = 0;

// Collision
hor_radius = 8;
ver_radius = 15;
wall_radius = 10;
resource_list = [];
terrain_list = [];

// Position grid
table_size = 12;
trail_alpha = array_create(table_size, 0);
pos_grid = [
	array_create(table_size, x),
	array_create(table_size, y),
];

// Timers
ground_lock = 0;
invincibility_timer = 0;
recovery_timer = 0;
stumble_timer = 30;
superspeed_timer = 0;

// Physics
accel = 0.046875;
air_accel = 0.09375;
air_frict = 0.96875;
air_threshold = 0.125;
ceiling_threshold = -4;
decel = 0.5;
frict = 0.046875;
grav_cap = 16;
grav_force = 0.21875;
grav_recoil = 0.1875;
gravity_direction = 0;
jump_height = 6.5;
jump_min_height = 4;
max_speed = 6;
roll_decel = 0.125;
roll_frict = 0.0234375;
roll_threshold = 1.03125;
skid_threshold = 4;
slope_frict = 0.125;
slope_frict_down = 0.3125;
slope_frict_up = 0.078125;
stumble_threshold = 2.5;
unroll_threshold = 0.5;

// Specific character functions
player_play_run = player_play_placeholder;

// Initialize values
player_set_ground(noone);
player_update_physics();
player_init_effects();
player_init_animations();

//tmp
layer = layer_get_id("General");
animation_index = "idle";
