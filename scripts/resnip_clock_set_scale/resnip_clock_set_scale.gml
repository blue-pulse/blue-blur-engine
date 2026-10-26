/// @func resnip_clock_set_scale(clock, scale)
/// @desc Sets the speed multiplier of a clock, where 1 is normal and 0 stops every playback that uses it. It has no native equivalent.
/// @param {Struct} clock The clock to change
/// @param {Real} scale The multiplier, 0 or above
function resnip_clock_set_scale(_clock, _scale) {
	if (_scale < 0) {
		__resnip_error("resnip_clock_set_scale received " + string(_scale) + ". Use 0 or above, and play backward with the backward option of resnip_play.");
	}
	_clock.scale = _scale;
}
