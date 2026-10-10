/// Moves an angle towards another one along the shortest arc, by at most the given increment.
/// Returns the new angle in degrees, wrapped between 0 and 360.
/// @param {Real} source Angle to move from, in degrees
/// @param {Real} target Angle to move towards, in degrees
/// @param {Real} increment Largest step to take, in degrees
function angle_approach(_source, _target, _increment) {
	var _diff = cycle(_target - _source, -180, 180);
	return angle_wrap(_source + clamp(_diff, -_increment, _increment));
}
