/// Returns one of the values by its index, which wraps around the number of values and counts negative indexes as 0.
/// @param {Real} index Index of the value to return
/// @param ... Values to pick from
function pick() {
	return argument[(max(0, argument[0]) mod (argument_count - 1)) + 1];
}
