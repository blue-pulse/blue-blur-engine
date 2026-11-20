function storage_is_idle() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return SparkleGetIdle();
}
