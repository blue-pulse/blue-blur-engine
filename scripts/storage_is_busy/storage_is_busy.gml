function storage_is_busy(_threshold=0) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Return true when busy now or within the threshold in milliseconds
	return SparkleGetRecentActivity(_threshold);
}
