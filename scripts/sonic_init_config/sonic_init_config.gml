function sonic_init_config() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Variables
	color_blend = make_color_rgb(33, 74, 223);
	trail_width = 10;

	// Dict
	data_boost = {
		aura: 0,
		spark: 0,
		wave: 0,
		grunt: [
			noone,
		],
	};

	data_dash = {
		sprite: spr_sonic_jumpball,
		sfx: snd_player_dash,
		grunt: [
			noone,
			noone,
			snd_sonic_laugh_a,
			snd_sonic_laugh_b,
			snd_sonic_laugh_c,
			snd_sonic_laugh_d,
			snd_sonic_laugh_e,
			snd_sonic_laugh_f,
		],
	};

	data_stomp = {
		sprite: 0,
		grunt: [
			snd_sonic_stomp_a,
		],
	};

	data_hud = {
		font: font_blue,
		icon: spr_sonic_lives,
		colors: [
			make_color_rgb(33, 74, 223),
			make_color_rgb(78, 194, 252)
		],
	};
}
