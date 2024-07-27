// Inherit the parent event
event_inherited();

// Set collision radiuses
df_radius_x = 9;
df_radius_y = 17;
sm_radius_x = 7;
sm_radius_y = 12;
radius_x = df_radius_x;
radius_y = df_radius_y;

// Set spawn point
pos_x = x;
pos_y = y - radius_y - 1;

// Assets
ast_hud = {
	spr_icon: spr_sonic_icon,
}

ast_boost = {
	img_blend: #64DCFF,
	par_trail: part_type_create_trail(#4EC2FC),
	spr_aura: spr_sonic_boost_aura,
	spr_spark: spr_sonic_boost_spark,
	spr_wave: spr_sonic_boost_wave,
	snd_clips: [
		snd_sonic_boost_a,
		snd_sonic_boost_b,
		snd_sonic_boost_c,
	],
}

ast_dash = {
	snd_sfx: snd_sonic_dash,
	snd_clips: [snd_sonic_boost_a, snd_sonic_boost_b],
}

ast_stomp = {
	spr_aura: spr_sonic_stomp_aura,
	snd_clips: [
		snd_sonic_stomp_a,
		snd_sonic_stomp_b,
	],
}

// Handle startup
sonic_params_update();
player_hitbox_update();
