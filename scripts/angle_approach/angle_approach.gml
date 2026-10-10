/// Moves an angle towards another one along the shortest arc, by at most the given increment.
/// Returns the new angle in degrees, which is wrapped between 0 and 360 as long as the source is not negative.
/// @param {Real} source Angle to move from, in degrees
/// @param {Real} target Angle to move towards, in degrees
/// @param {Real} increment Largest step to take, in degrees
function angle_approach(_source, _target, _increment) {
	var _diff = fmod(_target - _source + 540, 360) - 180;
	if (_diff > 0) {
		return fmod(_source + min(_diff, _increment), 360);
	}
	return fmod(360 - fmod(360 - (_source + max(-_increment, _diff)), 360), 360);
}
