/// Returns a shallow copy of an array, so nested arrays and structs are shared with the original unlike variable_clone.
/// @param {Array} array Array to copy
function array_duplicate(_array) {
	var _new_array = [];
	array_copy(_new_array, 0, _array, 0, array_length(_array));
	return _new_array;
}
