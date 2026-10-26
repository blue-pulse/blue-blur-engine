/// @func resnip_set_frame_speed(playback, frame, speed)
/// @desc Changes the speed of one frame for one playback, while the game runs, without changing the shared snip. The speed multiplies the duration the sprite editor gives the frame when the snip asks for sprite_durations. A speed of 0 holds the playback on that frame until its speed changes or the playback plays another snip. The change lasts while the playback plays the same snip. It replaces snip_set_frame_speed of AESnips, which changed the snip for every user.
/// @param {Struct} playback The playback to change, which must play a snip
/// @param {Real} frame The frame of that snip, counted from 0
/// @param {Real} speed The speed of that frame, 0 or above, or undefined to use the value of the snip again
function resnip_set_frame_speed(_playback, _frame, _speed) {
	// Prevent a playback with no snip
	var _snip = _playback.snip;
	if (_snip == undefined) {
		__resnip_error("resnip_set_frame_speed received a playback that plays no snip. Play a snip with resnip_play first.");
	}

	// Prevent a frame outside the snip
	__resnip_check_frame(_frame, _snip.count, "resnip_set_frame_speed");

	// Prevent a speed that cannot be used
	if (_speed != undefined && _speed < 0) {
		__resnip_error("resnip_set_frame_speed received speed " + string(_speed) + ". Use a speed of 0 or above, and play backward with the backward option of resnip_play.");
	}

	// Copy the speeds of the snip on the first change
	if (_playback.__frame_speeds == _snip.__frame_speeds) {
		_playback.__frame_speeds = array_create(_snip.count);
		array_copy(_playback.__frame_speeds, 0, _snip.__frame_speeds, 0, _snip.count);
	}

	// Store the speed divided by the duration the sprite gives the frame, as the snip does
	var _duration = (_snip.__durations == undefined) ? 1 : _snip.__durations[_frame];
	_playback.__frame_speeds[_frame] = (_speed == undefined) ? _snip.__frame_speeds[_frame] : _speed / _duration;
}
