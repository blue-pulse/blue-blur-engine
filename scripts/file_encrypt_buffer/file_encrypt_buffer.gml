function file_encrypt_buffer(_buffer) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Return value
	return SphinxEncryptBuffer(_buffer, XOR_KEY);
}
