/// @func resnip_clock_default()
/// @desc Returns the clock that playbacks use when they are not given one, which works as a pause for every such playback. It has no native equivalent.
/// @returns {Struct} The default clock
function resnip_clock_default() {
	return __resnip_system().clock;
}
