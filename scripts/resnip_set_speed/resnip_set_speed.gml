/// @func resnip_set_speed(playback, speed)
/// @desc Sets the speed of one playback, which multiplies the speed of the snip and of each frame. It replaces changing image_speed.
/// @param {Struct} playback The playback to change
/// @param {Real} speed The multiplier, 0 or above
function resnip_set_speed(_playback, _speed) {
	if (_speed < 0) {
		__resnip_error("resnip_set_speed received " + string(_speed) + ". Use 0 or above, and play backward with the backward option of resnip_play.");
	}
	_playback.speed = _speed;
}
