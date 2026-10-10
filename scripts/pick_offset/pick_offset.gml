/// Returns one of the values by its index, counted from a first index other than 0, without wrapping.
/// @param {Real} index Index of the value to return
/// @param {Real} first_index Index of the first value
/// @param ... Values to pick from
function pick_offset() {
	return argument[(argument[0] - argument[1]) + 2];
}
