function animation_create(_sprite, _options={}) {
	// Variables
	var _is_backward = _options[$ "is_backward"] ?? false;
	var _next = _options[$ "next"];
	var _snip_options = {
		speed: _options[$ "speed"] ?? ANIMATION_DEFAULT_SPEED,
		first_image: _options[$ "first_image"] ?? 0,
		last_image: _options[$ "last_image"],
	};

	// Continue into the next animation
	if (_next != undefined) {
		_snip_options.next = _next.__snip;
		_snip_options.next_options = { transition: ANIMATION_USE_TRANSITIONS, backward: _next.__is_backward };
	}

	// Return value
	return {
		__snip: resnip_snip_create(_sprite, _snip_options),
		__is_backward: _is_backward,
		__play_options: { transition: ANIMATION_USE_TRANSITIONS, restart: false, backward: _is_backward },
	};
}
