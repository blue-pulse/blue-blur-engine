function enemy_invoke_turn(_state) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	state = _state;
	state_timer = 0;
	hspeed = 0;
}
