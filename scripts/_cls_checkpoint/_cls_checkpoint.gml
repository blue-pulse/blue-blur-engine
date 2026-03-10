function _cls_checkpoint() constructor {
	// Variables
	time = 0;
	scoring = 0;
	room_pos = [0, 0];
	hub_pos = [0, 0];
	
	// Get status
	function get_status() {
		return (time > 0);
	}
	
	// Get checkpoint
	function get_data() {
		return [time, scoring, room_pos];
	}
	
	// Get hub data
	function get_hub() {
		return hub_pos;
	}
	
	// Set checkpoint
	function set_data(_time, _score, _pos) {
		time = _time;
		scoring = _score;
		room_pos = _pos;
	}
	
	// Set hub data
	function set_hub(_x, _y) {
		hub_pos = [_x, _y];
	}
	
	// Reset checkpoint
	function reset() {
		set_data(0, 0, [0, 0]);
		print("[INFO] Checkpoint parameters were restarted!");
	}
	
	// Reset hub data
	function reset_all() {
		reset();
		set_hub(0, 0);
		print("[INFO] Hub parameters were restarted!");
	}
}
