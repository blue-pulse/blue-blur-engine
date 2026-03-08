function file_load_userdata(slot) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Load slot
	global.slot = slot;
	Files.Load(slot);
}
