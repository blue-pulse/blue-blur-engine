/// Converts a value from one range to another, without clamping it to the new range.
/// @param {Real} value Value to convert
/// @param {Real} in_min Lower end of the range the value is in
/// @param {Real} in_max Upper end of the range the value is in
/// @param {Real} out_min Lower end of the range to convert to
/// @param {Real} out_max Upper end of the range to convert to
function map(_value, _in_min, _in_max, _out_min, _out_max) {
	return (_value - _in_min) * (_out_max - _out_min) / (_in_max - _in_min) + _out_min;
}
