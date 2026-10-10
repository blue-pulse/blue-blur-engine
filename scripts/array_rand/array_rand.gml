/// Returns a random element of an array, without changing the array.
/// @param {Array} array Array to pick from
function array_rand(_array) {
	return array_shuffle(_array)[0];
}
