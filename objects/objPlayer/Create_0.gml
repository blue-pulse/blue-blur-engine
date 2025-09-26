/// @description Initialize
image_speed = 0;

// States and flags
state = player_is_starting;
spinning = false;
jumping = false;
jump_action = false;

// Movement and collision
soft_objects = [];
solid_objects = [];
collision_layer = 0;
cliff_sign = 0;
x_speed = 0;
y_speed = 0;
gravity_direction = 0;

// Collision mask
x_radius = 8;
y_radius = 15;
x_wall_radius = 10;

// Timers
control_lock_time = 0;
recovery_time = 0;
invincibility_time = 0;
superspeed_time = 0;
default_slide_lock = 30;
camera_look_time = 0;
pan_distance_up = -104;
pan_distance_down = 88;

// Counters
score_combo = 0;
spindash_charge = 0;
peelout_charge = 0;

// Camera and effects
camera = instance_create_layer(x, y, layer, objCamera, { gravity_direction });
invincibility_effect = noone;

// Ground and rotation values
player_set_ground(noone);

// Physics values
player_reset_physics();

// Physics constants
ceiling_land_threshold = -4;
slide_threshold = 2.5;
roll_threshold = 1.03125;
unroll_threshold = 0.5;
brake_threshold = 4;
air_friction_threshold = 0.125;
air_friction = 0.96875;
slope_friction = 0.125;
roll_slope_friction_up = 0.078125;
roll_slope_friction_down = 0.3125;
spindash_atrophy = 0.96875;

// Position table and trail
table_size = 16;
x_table = array_create(table_size, xstart);
y_table = array_create(table_size, ystart);
trail_alpha = array_create(table_size, 0);

// On-time input
input_action_pressed = false;

// Continuous input
input_left = false;
input_right = false;
input_up = false;
input_down = false;
input_action = false;

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