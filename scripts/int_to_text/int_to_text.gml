/// Converts a number to text padded with zeros on the left.
/// @param {Real} integer Number to convert
/// @param {Real} [amount_zeros] Width of the text
function int_to_text(_integer, _amount_zeros=2) {
	var _int_as_string = string(_integer);
	var _zeros_left = _amount_zeros - string_length(_int_as_string);
	return string_repeat("0", _zeros_left) + _int_as_string;
}
