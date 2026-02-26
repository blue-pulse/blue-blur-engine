function sonic_init_config() {
	// Variables
	color_blend = make_color_rgb(33, 74, 223);
	trail_alpha = array_create(table_size, 0);
	spr_jumpball = spr_sonic_jumpball;

	// Dict
	boost_params = {
		img_blend: make_color_rgb(33, 74, 223),
		aura: 0,
		spark: 0,
		wave: 0,
		voice_clips: [],
	};

	dash_params = {
		img_blend: make_color_rgb(33, 74, 223),
		aura: 0,
		sfx: 0,
		voice_clips: [
			noone,
			noone,
		],
	};

	stomp_params = {
		aura: 0,
		voice_clips: [],
	};

	hud_params = {
		font: font_blue,
		life_icon: spr_sonic_icon,
		colors_stamina: [
			make_color_rgb(33, 74, 223),
			make_color_rgb(78, 194, 252)
		],
	};
}
