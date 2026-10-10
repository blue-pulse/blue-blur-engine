/// Returns the sign of a number as 1 or -1, and the fallback when the number is 0, unlike sign which returns 0.
/// @param {Real} value Number to check
/// @param {Real} fallback Value to return when the number is 0
function esign(_value, _fallback) {
	if (_value == 0) {
		return _fallback;
	}
	if (_value > 0) {
		return 1;
	}
	return -1;
}
