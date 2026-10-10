/// Returns a random element of an array, or undefined when the array is empty, without changing or copying the array.
/// @param {Array} array Array to pick from
function array_rand(_array) {
	if (array_length(_array) == 0) {
		return undefined;
	}
	return _array[irandom(array_length(_array) - 1)];
}
