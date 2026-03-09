function file_decrypt_buffer(_buffer) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return SphinxDecryptBuffer(_buffer, XOR_KEY);
}
