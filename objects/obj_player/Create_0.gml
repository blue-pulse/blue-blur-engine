// Basic variables
depth = queue.player;
animation = noone;
rings = 0;
score_combo = 0;
scoring = global.score;

// State flags
allow_movement = true;
invincibility_fx = noone;
is_jumping = false;
is_rolling = false;
jump_action = false;
peelout_charge = 0;
spindash_charge = 0;
state = player_state_init;
state_prev = state;

// Movement
cliff_dir = 0;
hor_speed = 0;
ver_speed = 0;
plane = 0;

// Collision
hor_radius = 8;
ver_radius = 15;
wall_radius = 10;
resource_list = [];
terrain_list = [];

// Position grid
table_size = 16;
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
gravity_direction = 0;
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
jump_height = 6.5;
jump_min_height = 4;
roll_decel = 0.125;
roll_frict = 0.0234375;
roll_threshold = 1.03125;
skid_threshold = 4;
slope_frict = 0.125;
slope_frict_down = 0.3125;
slope_frict_up = 0.078125;
speed_cap = 6;
spindash_atrophy = 0.96875;
stumble_threshold = 2.5;
unroll_threshold = 0.5;

// Specific character functions
player_play_run = player_play_placeholder;

// Initialize values
player_set_ground(noone);
player_update_physics();
player_init_effects();
player_init_animations();

// Trash
layer = layer_get_id("General");
animation_index = "idle";
