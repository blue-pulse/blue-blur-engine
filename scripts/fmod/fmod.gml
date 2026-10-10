/// Returns the remainder of a division, which takes the sign of the dividend, and NaN when dividing by zero.
/// @param {Real} dividend Number to divide
/// @param {Real} divisor Number to divide by
function fmod(_dividend, _divisor) {
	if (_divisor == 0) {
		return NaN;
	}
	return _dividend - (_dividend div _divisor) * _divisor;
}
