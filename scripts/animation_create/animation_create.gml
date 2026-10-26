function animation_create(_sprite, _options={}) {
	// Variables
	var reversed = _options[$ "reversed"] ?? false;
	var next = _options[$ "next"];
	var snip_options = {
		speed: _options[$ "speed"] ?? ANIMATION_DEFAULT_SPEED,
		first_image: _options[$ "first_image"] ?? 0,
		last_image: _options[$ "last_image"],
	};

	// Continue into the next animation
	if (next != undefined) {
		snip_options.next = next.__snip;
		snip_options.next_options = { transition: ANIMATION_USE_TRANSITIONS, backward: next.__reversed };
	}

	// Return value
	return {
		__snip: resnip_snip_create(_sprite, snip_options),
		__reversed: reversed,
		__play_options: { transition: ANIMATION_USE_TRANSITIONS, restart: false, backward: reversed },
	};
}
