/// @func resnip_clock_create()
/// @desc Creates a clock that playbacks share. Set its paused field to pause every playback that uses it, and change its speed with resnip_clock_set_scale. It has no native equivalent.
/// @returns {Struct} The clock, with the fields paused and scale
function resnip_clock_create() {
	return { paused: false, scale: 1 };
}
