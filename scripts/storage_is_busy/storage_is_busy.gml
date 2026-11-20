function storage_is_busy() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return SparkleGetBusy();
}
