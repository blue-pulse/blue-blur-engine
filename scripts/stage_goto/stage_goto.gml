function stage_goto(_room, _duration=30) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Player parameters
	global.time = 0
	global.score = 0;
	
	// Restart room
	room_fadeto(_room, _duration, c_black, true);
}
