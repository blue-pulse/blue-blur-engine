// Inherit the parent event
event_inherited();

// Collision radiuses
big_radius_x = 9;
big_radius_y = 17;
small_radius_x = 7;
small_radius_y = 12;
radius_x = big_radius_x;
radius_y = big_radius_y;

// Spawn point
pos_x = x;
pos_y = y - radius_y - 1;

// Assets
snd_attack = [
	snd_sonic_attack_a,
	snd_sonic_attack_b,
	snd_sonic_attack_c,
	snd_sonic_attack_d,
];

ast_boost = {
	img_blend: #64DCFF,
	par_trail: part_type_create_trail(#33A8FF),
	spr_aura: spr_sonic_boost_aura,
	spr_spark: spr_sonic_boost_spark,
	spr_wave: spr_sonic_boost_wave,
	snd_clips: [
		noone,
		snd_sonic_boost_a,
		snd_sonic_boost_b,
		snd_sonic_boost_c,
	],
}

ast_dash = {
	spr_aura: spr_sonic_jumpball,
	snd_sfx: snd_sonic_dash,
}

ast_stomp = {
	spr_aura: spr_sonic_stomp_aura,
	snd_clips: [
		noone,
		snd_sonic_stomp_a,
		snd_sonic_stomp_b,
	],
}

ast_hud = {
	font: fnt_hud_blue,
	spr_lives: spr_sonic_lives,
	colors_stamina: [
		make_color_rgb(33, 74, 223),
		make_color_rgb(78, 194, 252)
	],
};

// Handle startup
sonic_update_physics();
player_update_hitbox();
