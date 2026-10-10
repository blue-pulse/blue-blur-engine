/// Returns a string of random characters taken from a set, or from the printable ASCII characters when the set is empty.
/// @param {String} text Characters to pick from
/// @param {Real} length Number of characters to return
function random_string(_text, _length) {
	var _out = "";
	var _len = string_length(_text);
	if (_len > 0) {
		repeat (_length) {
			_out += string_char_at(_text, floor(random(_len)) + 1);
		}
	} else {
		repeat (_length) {
			_out += chr(floor(random(95)) + 32);
		}
	}
	return _out;
}
