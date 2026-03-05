function file_get_userdata(slot) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Get save data
	return ssave_get(save_file, slot);
}
