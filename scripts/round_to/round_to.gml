/// Rounds a value to the nearest multiple of a number.
/// @param {Real} value Value to round
/// @param {Real} multiple Number whose multiples to round to
function round_to(_value, _multiple) {
	return round(_value / _multiple) * _multiple;
}
