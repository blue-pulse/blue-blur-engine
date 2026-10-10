/// Divides two numbers and returns 0 when dividing by zero.
/// @param {Real} dividend Number to divide
/// @param {Real} divisor Number to divide by
function safe_div(_dividend, _divisor) {
	return (_divisor != 0) ? (_dividend / _divisor) : (0);
}
