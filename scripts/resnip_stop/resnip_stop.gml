/// @func resnip_stop(playback, [where])
/// @desc Stops a playback where it is, on the first frame or on the last frame, until it is told to play again. Pause is different, since it keeps the state and resumes. It does nothing if the playback plays no snip.
/// @param {Struct} playback The playback to stop
/// @param {Constant.RESNIP_STOP} [where] Where to leave it (default RESNIP_STOP.HERE)
function resnip_stop(_playback, _where = RESNIP_STOP.HERE) {
	// Prevent stopping a playback with no snip
	if (_playback.snip == undefined) {
		return;
	}

	// Move to the chosen frame
	if (_where == RESNIP_STOP.HEAD) {
		_playback.frame = 0;
		_playback.__progress = 0;
	} else if (_where == RESNIP_STOP.TAIL) {
		_playback.frame = _playback.snip.count - 1;
		_playback.__progress = 0;
	}

	// Stop
	_playback.stopped = true;
	_playback.__target = undefined;
}
