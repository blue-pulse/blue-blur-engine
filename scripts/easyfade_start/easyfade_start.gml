/// Fades the screen to a colour and back, without changing room.
/// Returns whether the fade started, which it does not while another fade is in progress.
/// @param {Real} [duration] Frames each half of the fade lasts, where anything below 1 counts as 1
/// @param {Constant.Colour} [color] Colour of the fade
/// @param {Bool} [fade_audio] Whether the master volume fades out and in with the screen
function easyfade_start(_duration=EASYFADE_DEFAULT_DURATION, _color=EASYFADE_DEFAULT_COLOR, _fade_audio=false) {
	return __easyfade_begin(noone, _duration, _color, _fade_audio);
}
