function cipher_encrypt(_buffer) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return SphinxEncryptBuffer(_buffer, CIPHER_KEY);
}
