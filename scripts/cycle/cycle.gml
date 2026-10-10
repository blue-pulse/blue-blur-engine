/// Wraps a value into the range from min up to max, so a value past either end comes back around, however far it is.
/// Raises an error when min and max are equal, because there is no range to wrap into.
/// @param {Real} value Value to wrap
/// @param {Real} min Lower end of the range, which is included
/// @param {Real} max Upper end of the range, which is excluded
function cycle(_value, _min, _max) {
	var _delta = _max - _min;
	if (_delta == 0) {
		show_error("GMUtils: cycle was given a min and a max that are equal, so there is no range to wrap into! Pass a max greater than min.", true);
	}
	return _min + ((((_value - _min) mod _delta) + _delta) mod _delta);
}
