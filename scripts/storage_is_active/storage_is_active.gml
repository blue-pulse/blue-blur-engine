function storage_is_active() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return value
	return SparkleGetRecentActivity(STORAGE_ACTIVE_TIME);
}
