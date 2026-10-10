/// Rotates an angle towards another one along the shortest arc, snapping to the target when it is close.
/// The result is not wrapped, so use angle_wrap on it if it must stay between 0 and 360.
/// @param {Real} source Angle to rotate from, in degrees
/// @param {Real} target Angle to rotate towards, in degrees
/// @param {Real} speed Largest step to take, in degrees
function angle_rotate(_source, _target, _speed) {
	var _diff = cycle(_target - _source, -180, 180);
	if (_diff < -_speed) {
		return (_source - _speed);
	}
	if (_diff > _speed) {
		return (_source + _speed);
	}
	return _target;
}
