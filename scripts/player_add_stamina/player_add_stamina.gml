function player_add_stamina(amount) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	stamina = min(stamina + amount, 100);
}
