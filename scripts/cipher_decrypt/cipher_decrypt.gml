function cipher_decrypt(_buffer) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return SphinxDecryptBuffer(_buffer, CIPHER_KEY);
}
