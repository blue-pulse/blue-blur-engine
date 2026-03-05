function file_save_userdata() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Save the active slot index
	Files.Save(global.slot);
}
