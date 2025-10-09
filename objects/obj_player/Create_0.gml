// Initialize
image_speed = 0;
layer = layer_get_id("General");

// States and flags
state = player_is_starting;
state_prev = state;
is_rolling = false;
is_jumping = false;
jump_action = false;

// Movement and collision
resource_list = [];
terrain_list = [];
plane = 0;
cliff_dir = 0;
hor_speed = 0;
ver_speed = 0;
gravity_direction = 0;

// Collision mask
hor_radius = 8;
ver_radius = 15;
wall_radius = 10;

// Timers
gnd_lock = 0;
recovery_timer = 0;
invincibility_timer = 0;
superspeed_timer = 0;
slide_timer = 30;

// Counters
score_combo = 0;
rings = 0;
spindash_charge = 0;
peelout_charge = 0;

// Camera and effects
invincibility_effect = noone;

// Ground and rotation values
player_set_ground(noone);

// Physics values
player_update_physics();

// Physics constants
ceiling_threshold = -4;
slide_threshold = 2.5;
roll_threshold = 1.03125;
unroll_threshold = 0.5;
brake_threshold = 4;
air_threshold = 0.125;
air_frict = 0.96875;
slope_frict = 0.125;
slope_frict_up = 0.078125;
slope_frict_down = 0.3125;
spindash_atrophy = 0.96875;

// Position table and trail
table_size = 16;
trail_alpha = array_create(table_size, 0);
pos_grid = [
	array_create(table_size, x),
	array_create(table_size, y),
];

// Animations
animations =
{
	idle : animSonicIdle,
	walk : animSonicWalk,
	run : animSonicRun,
	sprint : animSonicSprint,
	spin : animSonicSpin,
	push : animSonicPush,
	look : animSonicLook,
	crouch : animSonicCrouch,
	spindash : animSonicSpindash,
	brake : animSonicBrake,
	rise : animSonicRise,
	fall : animSonicFall,
	teeter : animSonicTeeter,
	hurt : animSonicHurt,
	dead : animSonicDead
};
animation_index = "idle";