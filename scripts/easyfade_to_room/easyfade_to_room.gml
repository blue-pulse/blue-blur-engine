/// Fades the screen to a colour, changes room at the peak and fades back.
/// Returns whether the fade started, which it does not while another fade is in progress or when the room does not exist.
/// @param {Asset.GMRoom} room Room to go to
/// @param {Real} [duration] Frames each half of the fade lasts, where anything below 1 counts as 1
/// @param {Constant.Colour} [color] Colour of the fade
/// @param {Bool} [fade_audio] Whether the master volume fades out and in with the screen
function easyfade_to_room(_room, _duration=EASYFADE_DEFAULT_DURATION, _color=EASYFADE_DEFAULT_COLOR, _fade_audio=false) {
	return __easyfade_begin(_room, _duration, _color, _fade_audio);
}
