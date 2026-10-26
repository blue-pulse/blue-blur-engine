/// @func resnip_set_loop_repeats(playback, loop, repeats)
/// @desc Changes how many times a loop repeats for one playback, while the game runs, without changing the shared snip. A count of 0 plays the loop once and below 0 skips it. The count is read when the playback enters the loop and each time it reaches the end of the loop, so a change applies at the next of those. It replaces snip_set_loop_repeat of AESnips, which changed the loop for every user.
/// @param {Struct} playback The playback to change
/// @param {Struct} loop A loop of a snip, read from its loops array
/// @param {Real} repeats The number of repeats after the first play, or undefined to use the loop value again
function resnip_set_loop_repeats(_playback, _loop, _repeats) {
	// Clear the override
	if (_repeats == undefined) {
		if (_playback.__repeats != undefined) {
			variable_struct_remove(_playback.__repeats, _loop.__key);
		}
		return;
	}

	// Prevent a count that is not whole
	if (_repeats != floor(_repeats)) {
		__resnip_error("resnip_set_loop_repeats received " + string(_repeats) + ". Use a whole number, where 0 plays once and below 0 skips the loop.");
	}

	// Store the override
	_playback.__repeats ??= {};
	_playback.__repeats[$ _loop.__key] = _repeats;
}
