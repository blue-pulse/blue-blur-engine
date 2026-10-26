function __resnip_check_frame(_frame, _count, _where) {
	if (_frame < 0 || _frame >= _count || _frame != floor(_frame)) {
		__resnip_error(_where + " received frame " + string(_frame) + " but the snip has " + string(_count) + " frames, numbered 0 to " + string(_count - 1) + ". Use a whole number in that range.");
	}
}
