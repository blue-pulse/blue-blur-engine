function _fade_get_alpha() {
	var fade_inst = _fade_get_id();
	if (fade_inst != noone) {
		return fade_inst.alpha;
	}
	return 0;
}
