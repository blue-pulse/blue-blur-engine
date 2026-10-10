/// Wraps a value into the range from min up to max, so a value past max comes back around from min.
/// @param {Real} value Value to wrap
/// @param {Real} min Lower end of the range, which is included
/// @param {Real} max Upper end of the range, which is excluded
function cycle(_value, _min, _max) {
	var _delta = _max - _min;
	return _min + ((_value - _min + _delta) mod _delta);
}
