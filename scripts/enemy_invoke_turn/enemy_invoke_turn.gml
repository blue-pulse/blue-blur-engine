function enemy_invoke_turn() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	state = 1;
	hspeed = 0;
	animation_play(anim_turn);
}
