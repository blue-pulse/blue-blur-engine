/// Returns the opacity of the fade, or 0 when no fade is in progress.
function easyfade_get_alpha() {
	var _controller = __easyfade_find_controller();
	if (_controller != noone) {
		return _controller.__alpha;
	}
	return 0;
}
