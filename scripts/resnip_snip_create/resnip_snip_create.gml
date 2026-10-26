/// @func resnip_snip_create(sprite, [options])
/// @desc Creates a snip, which is a sprite or a run of its sub-images with a speed, loops and scripts. A snip is shared by every playback and must not be changed after it is created, so make a variation with resnip_snip_clone. Create snips once, such as in a Create event or behind a loading screen, because sprite_durations reads the sprite. A sprite copied with sprite_duplicate has no durations. It has no native equivalent. Frames of loops, speeds and scripts count from 0 at the first image of the snip.
/// @param {Asset.GMSprite} sprite The sprite to play
/// @param {Struct} [options] Optional fields: first_image and last_image (sub-images, default the whole sprite), speed (0 or above, default 1), frame_speeds (array of {frame, speed}, where a speed of 0 holds the frame), sprite_durations (true to play each frame for the duration the sprite editor gives it, multiplied by its frame speed, default false), frame_scripts (array of {frame, callback, argument}), loops (array of {first, last, repeats}, where repeats 0 plays the frames once and below 0 skips them), end_mode (RESNIP_END), complete_on (RESNIP_COMPLETE), on_complete and on_complete_argument, next (a snip) and next_options ({transition, backward}, see resnip_snip_set_next)
/// @returns {Struct} The snip
function resnip_snip_create(_sprite, _options = {}) {
	// Sprite
	if (!sprite_exists(_sprite)) {
		__resnip_error("resnip_snip_create received a sprite that does not exist. Pass a sprite asset.");
	}

	// Images
	var _sprite_count = sprite_get_number(_sprite);
	var _first_image = _options[$ "first_image"] ?? 0;
	var _last_image = _options[$ "last_image"] ?? _sprite_count - 1;
	if (_first_image < 0 || _last_image >= _sprite_count || _first_image > _last_image) {
		__resnip_error("resnip_snip_create received first_image " + string(_first_image) + " and last_image " + string(_last_image) + " but " + sprite_get_name(_sprite) + " has " + string(_sprite_count) + " sub-images, numbered 0 to " + string(_sprite_count - 1) + ". Use a range inside the sprite with the first image not after the last.");
	}

	// Speed
	var _speed = _options[$ "speed"] ?? RESNIP_DEFAULT_SNIP_SPEED;
	if (_speed < 0) {
		__resnip_error("resnip_snip_create received speed " + string(_speed) + ". Use a speed of 0 or above, and play backward with the backward option of resnip_play.");
	}

	// End mode
	var _end_mode = _options[$ "end_mode"] ?? RESNIP_DEFAULT_END_MODE;
	if (_end_mode < RESNIP_END.HOLD || _end_mode > RESNIP_END.PINGPONG) {
		__resnip_error("resnip_snip_create received end_mode " + string(_end_mode) + ". Use a value of RESNIP_END.");
	}

	// Completion mode
	var _complete_on = _options[$ "complete_on"] ?? RESNIP_DEFAULT_COMPLETE_ON;
	if (_complete_on < RESNIP_COMPLETE.EDGE || _complete_on > RESNIP_COMPLETE.TAIL) {
		__resnip_error("resnip_snip_create received complete_on " + string(_complete_on) + ". Use a value of RESNIP_COMPLETE.");
	}

	// Completion script
	var _on_complete = _options[$ "on_complete"];
	if (_on_complete != undefined && !is_callable(_on_complete)) {
		__resnip_error("resnip_snip_create received an on_complete that cannot be called. Pass a function or a method.");
	}

	// Next snip
	var _next = _options[$ "next"];
	if (_next != undefined && !is_struct(_next)) {
		__resnip_error("resnip_snip_create received a next that is not a snip. Pass the result of resnip_snip_create.");
	}

	// How the next snip plays
	var _next_options = _options[$ "next_options"] ?? {};
	if (!is_struct(_next_options)) {
		__resnip_error("resnip_snip_create received next_options that are not a struct. Pass {transition, backward}.");
	}

	// Durations of the sprite
	var _sprite_durations = _options[$ "sprite_durations"] ?? false;
	if (!is_bool(_sprite_durations)) {
		__resnip_error("resnip_snip_create received sprite_durations " + string(_sprite_durations) + ". Pass true to play each frame for the duration the sprite editor gives it, or leave it out.");
	}

	// Build the snip
	var _count = _last_image - _first_image + 1;
	var _loops = __resnip_snip_build_loops(_options[$ "loops"] ?? [], _count);
	var _frame_speeds = __resnip_snip_build_frame_speeds(_options[$ "frame_speeds"] ?? [], _count);
	var _durations = _sprite_durations ? __resnip_snip_build_durations(_sprite, _first_image, _count) : undefined;

	// Speeds the step reads, with each frame speed divided by the duration the sprite gives the frame
	var _step_speeds = _frame_speeds;
	if (_durations != undefined) {
		_step_speeds = array_create(_count);
		for (var _i = 0; _i < _count; _i++) {
			_step_speeds[_i] = _frame_speeds[_i] / _durations[_i];
		}
	}
	return {
		// Public fields
		sprite: _sprite,
		first_image: _first_image,
		last_image: _last_image,
		count: _count,
		speed: _speed,
		sprite_speed: sprite_get_speed(_sprite),
		sprite_speed_type: sprite_get_speed_type(_sprite),
		frame_speeds: _frame_speeds,
		frame_scripts: __resnip_snip_build_frame_scripts(_options[$ "frame_scripts"] ?? [], _count),
		loops: _loops,
		end_mode: _end_mode,
		complete_on: _complete_on,
		on_complete: _on_complete,
		on_complete_argument: _options[$ "on_complete_argument"],
		next: _next,
		next_transition: _next_options[$ "transition"] ?? true,
		next_backward: _next_options[$ "backward"] ?? false,
		// Private fields
		__id: __resnip_next_id(),
		__options: __resnip_options_merge({}, _options),
		__loops_at: __resnip_snip_build_loops_at(_loops, _count),
		__durations: _durations,
		__frame_speeds: _step_speeds,
		__scale: _speed * sprite_get_speed(_sprite),
		__per_second: sprite_get_speed_type(_sprite) == spritespeed_framespersecond,
	};
}
