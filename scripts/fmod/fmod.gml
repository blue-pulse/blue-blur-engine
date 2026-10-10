/// Returns the remainder of a division, which takes the sign of the dividend, and NaN when dividing by zero.
/// Unlike a remainder built on div it is also correct for divisors below 1 and with decimals.
/// @param {Real} dividend Number to divide
/// @param {Real} divisor Number to divide by
function fmod(_dividend, _divisor) {
	if (_divisor == 0) {
		return NaN;
	}
	return _dividend - trunc(_dividend / _divisor) * _divisor;
}
