/// @func resnip_debug_draw(playback, x, y)
/// @desc Draws every sub-image of the sprite of a playback in a row, with the current frame lifted and its progress as a bar, a dot under frames that have a script, and a bracket under each loop. Loops are aqua when they repeat, green while played, yellow when they play once and red when skipped. It is a separate module, so leave it out of a build that does not need it. It has no native equivalent.
/// @param {Struct} playback The playback to inspect
/// @param {Real} x The x position of the panel
/// @param {Real} y The y position of the panel
function resnip_debug_draw(_playback, _x, _y) {
	// Variables
	var _old_color = draw_get_color();
	var _old_alpha = draw_get_alpha();
	var _snip = _playback.snip;

	// Playback with no snip
	if (_snip == undefined) {
		draw_set_color(__RESNIP_DEBUG_EMPTY_COLOR);
		draw_rectangle(_x, _y, _x + 16, _y + 16, false);
		draw_set_color(_old_color);
		return;
	}

	// Panel size
	var _sprite = _snip.sprite;
	var _width = sprite_get_width(_sprite);
	var _height = sprite_get_height(_sprite);
	var _step = _width + __RESNIP_DEBUG_GAP;
	var _lift = floor(_height * __RESNIP_DEBUG_LIFT);
	var _line = floor(_width * __RESNIP_DEBUG_LOOP_LINE);
	var _current = resnip_frame_to_image(_snip, _playback.frame);

	// Sub-images
	for (var _i = 0; _i < sprite_get_number(_sprite); _i++) {
		var _x1 = _x + _i * _step;
		var _y2 = _y + _height + ((_i == _current) ? _lift : 0);
		var _in_snip = (_i >= _snip.first_image && _i <= _snip.last_image);

		draw_set_alpha(_in_snip ? 1 : __RESNIP_DEBUG_FADED_ALPHA);
		draw_set_color(__RESNIP_DEBUG_BACK_COLOR);
		draw_rectangle(_x1, _y, _x1 + _width, _y2, false);
		draw_sprite(_sprite, _i, _x1 + sprite_get_xoffset(_sprite), _y + sprite_get_yoffset(_sprite));

		if (_in_snip && _snip.frame_scripts[resnip_image_to_frame(_snip, _i)] != undefined) {
			draw_set_color(__RESNIP_DEBUG_SCRIPT_COLOR);
			draw_ellipse(_x1 + _width / 2, _y + _height, _x1 + _width / 2 + __RESNIP_DEBUG_DOT_SIZE, _y + _height + __RESNIP_DEBUG_DOT_SIZE, false);
		}
	}

	// Progress of the current frame
	draw_set_alpha(1);
	draw_set_color(__RESNIP_DEBUG_PROGRESS_COLOR);
	var _bar_x = _x + _current * _step;
	draw_rectangle(_bar_x, _y + _height + 1, _bar_x + _width * _playback.__progress, _y + _height + _lift - 1, false);

	// Loops
	for (var _i = 0; _i < array_length(_snip.loops); _i++) {
		var _loop = _snip.loops[_i];
		var _repeats = __resnip_loop_repeat(_playback, _loop);
		if (_repeats > 0) {
			draw_set_color((_playback.__loop == _i) ? __RESNIP_DEBUG_LOOP_ACTIVE_COLOR : __RESNIP_DEBUG_LOOP_COLOR);
			draw_set_alpha(__RESNIP_DEBUG_LOOP_ALPHA);
		} else {
			draw_set_color((_repeats < 0) ? __RESNIP_DEBUG_LOOP_SKIP_COLOR : __RESNIP_DEBUG_LOOP_ONCE_COLOR);
			draw_set_alpha(__RESNIP_DEBUG_SKIPPED_ALPHA);
		}

		var _start_x = _x + resnip_frame_to_image(_snip, _loop.first) * _step;
		var _end_x = _x + resnip_frame_to_image(_snip, _loop.last) * _step + _width;
		var _bar_y = _y + _height + _lift + 1 + _i * (_line + __RESNIP_DEBUG_GAP);
		draw_rectangle(_start_x, _y + _height + 1, _start_x + _line, _bar_y + _line, false);
		draw_rectangle(_end_x - _line, _y + _height + 1, _end_x, _bar_y + _line, false);
		draw_rectangle(_start_x, _bar_y, _end_x, _bar_y + _line, false);
	}

	// Restore the draw state
	draw_set_color(_old_color);
	draw_set_alpha(_old_alpha);
}
