function sonic_init_config() {
	// Variables
	color_blend = c_blue;
	trail_alpha = array_create(table_size, 0);

	// Dict
	boost_params = {
		img_blend: c_blue,
		aura: 0,
		spark: 0,
		wave: 0,
		voice_clips: [],
	};

	dash_params = {
		img_blend: c_blue,
		aura: 0,
		sfx: 0,
		voice_clips: [],
	};

	stomp_params = {
		aura: 0,
		voice_clips: [],
	};

	hud_params = {
		font: font_black,
		life_icon: 0,
		stamina_colors: [c_blue, c_blue],
	};
}
