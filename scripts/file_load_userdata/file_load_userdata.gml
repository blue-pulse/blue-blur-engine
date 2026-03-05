function file_load_userdata(slot) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Load slot
	Files.Load(slot);
}
