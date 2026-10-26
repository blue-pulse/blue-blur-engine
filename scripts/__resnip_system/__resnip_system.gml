function __resnip_system() {
	static _state = {
		clock: { paused: false, scale: 1 },
		transitions: {},
		last_id: 0,
	};
	return _state;
}
