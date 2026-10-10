/// Converts a number to text padded with zeros on the left, and a negative number keeps its sign before the zeros.
/// @param {Real} integer Number to convert
/// @param {Real} [amount_zeros] Width of the text, without counting the sign
function int_to_text(_integer, _amount_zeros=2) {
	var _int_as_string = string(abs(_integer));
	var _zeros_left = _amount_zeros - string_length(_int_as_string);
	var _sign = (_integer < 0) ? "-" : "";
	return _sign + string_repeat("0", _zeros_left) + _int_as_string;
}
