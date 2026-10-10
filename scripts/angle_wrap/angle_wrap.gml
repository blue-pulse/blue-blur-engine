/// Wraps an angle into the range from 0 up to 360, which stays positive for negative angles unlike the mod operator.
/// @param {Real} value Angle in degrees
function angle_wrap(_value) {
	return ((_value mod 360) + 360) mod 360;
}
