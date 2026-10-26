function __resnip_next_id() {
	var _state = __resnip_system();
	_state.last_id++;
	return _state.last_id;
}
