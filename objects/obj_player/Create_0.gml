// Set global variables
depth = orders.player;
score = global.player_score;
lives = global.player_lives;

// Set basic parameters
pos_x = x;
pos_y = y;
angle = 0;
opacity = 1;
rotation = 360;

// Initialise physics variables
accel = 0;
air_accel = 0;
decel = 0;
frict = 0;
gnd_speed = 0;
hor_speed = 0;
jump_height = 0;
max_hor_speed = 0;
max_ver_speed = 15.75;
max_abs_speed = 16;
min_jump_height = 0;
roll_decel = 0;
roll_frict = 0;
ver_speed = 0;

// Set collision radiuses
df_radius_x = 9;
df_radius_y = 19;
sm_radius_x = 7;
sm_radius_y = 14;
radius_x = df_radius_x;
radius_y = df_radius_y;

// Set defaults
allow_collision = true;
allow_movement = true;
collision_mode = [0, 0];
dir = RIGHT;
grv = 0.21875;
hitbox = [0, 0];
on_object = noone;
plane = 0;
spindash_revolutions = -1;
state = states.falling;
stamina = 100;
stick_to_convex = 0;

// Set flags
air_lock = false;
gnd_lock = false;
forced_roll = false;
is_being_hurt = false;
is_boosting = false;
is_dashing = false;
is_grounded = false;
is_jumping = false;
is_pushing = false;
is_rolling = false;
is_stomping = false;
is_underwater = false;

// Assets
ast_boost = {
	img_blend: #FFFFFF,
	par_trail: part_type_create_trail(#FFFFFF),
	spr_aura: 0,
	spr_spark: 0,
	spr_wave: 0,
	snd_clips: [],
}

ast_dash = {
	spr_aura: 0,
	snd_sfx: 0,
	snd_clips: [],
}

ast_hud = {
	spr_icon: 0,
}

ast_stomp = {
	spr_aura: 0,
	snd_clips: [],
}

// Remember last position
prev_pos_x = pos_x;
prev_pos_y = pos_y;

// Player startup
player_params_update();
player_hitbox_update();
