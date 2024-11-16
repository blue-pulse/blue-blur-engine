// Basic variables
depth = queue.player;
tmp_score = global.score;
rings = 0;

// Position variables
pos_x = x;
pos_y = y;
angle = 0;
opacity = 1;
rotation = 360;
prev_pos_x = pos_x;
prev_pos_y = pos_y;

// Collision radiuses
big_radius_x = 9;
big_radius_y = 19;
small_radius_x = 7;
small_radius_y = 14;
radius_x = big_radius_x;
radius_y = big_radius_y;

// Physics variables
accel = 0;
air_accel = 0;
decel = 0;
frict = 0;
grv = 0.21875;
gnd_speed = 0;
hor_speed = 0;
ver_speed = 0;
jump_height = 0;
min_jump_height = 0;
max_hor_speed = 0;
max_ver_speed = 15.75;
max_abs_speed = 16;
roll_decel = 0;
roll_frict = 0;

// Control variables
allow_collision = true;
allow_movement = true;
collision_mode = [0, 0];
dir = RIGHT;
hitbox = [0, 0, 0, 0];
on_object = noone;
plane = 0;
invincibility_frames = 0;
state = states.fall;
stamina = 100;
stick_to_convex = 0;

// Flags
air_lock = false;
gnd_lock = false;
forced_roll = false;
forced_slide = false;
infinite_stamina = false;
is_being_hurt = false;
is_boosting = false;
is_dashing = false;
is_grounded = false;
is_jumping = false;
is_pushing = false;
is_rolling = false;
is_underwater = false;

// Assets
snd_attack = [];

snd_skid = [
	snd_player_skid,
	snd_player_skid_dirt,
	snd_player_skid_glass,
	snd_player_skid_grass,
	snd_player_skid_metal,
	snd_player_skid_stone,
	snd_player_skid_water,
	snd_player_skid_wood,
];

snd_land = [
	snd_player_land,
	snd_player_land_dirt,
	snd_player_land_glass,
	snd_player_land_grass,
	snd_player_land_metal,
	snd_player_land_stone,
	snd_player_land_water,
	snd_player_land_wood,
];

snd_footsteps = [
	[snd_player_lfs, snd_player_rfs],
	[snd_player_lfs_dirt, snd_player_rfs_dirt],
	[snd_player_lfs_glass, snd_player_rfs_glass],
	[snd_player_lfs_grass, snd_player_rfs_grass],
	[snd_player_lfs_metal, snd_player_rfs_metal],
	[snd_player_lfs_stone, snd_player_rfs_stone],
	[snd_player_lfs_water, snd_player_rfs_water],
	[snd_player_lfs_wood, snd_player_rfs_wood],
];

ast_boost = {
	img_blend: c_white,
	par_trail: part_type_create_trail(c_white),
	spr_aura: 0,
	spr_spark: 0,
	spr_wave: 0,
	snd_clips: [],
};

ast_dash = {
	spr_aura: 0,
	snd_sfx: 0,
};

ast_stomp = {
	spr_aura: 0,
	snd_clips: [],
};

ast_hud = {
	font: fnt_hud_black,
	spr_lives: 0,
	colors_stamina: [c_white, c_white],
};

// Handle startups
player_update_physics();
player_update_hitbox();
