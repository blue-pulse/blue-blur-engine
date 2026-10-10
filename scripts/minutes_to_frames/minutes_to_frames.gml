/// Converts minutes to frames.
/// @param {Real} minutes Time in minutes
/// @param {Real} game_speed Frames per second
function minutes_to_frames(_minutes, _game_speed) {
	return (_game_speed * 60 * _minutes);
}
