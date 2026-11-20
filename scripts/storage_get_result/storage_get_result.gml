function storage_get_result(_status) {
	// Successful operation
	if (_status == SPARKLE_STATUS_SUCCESS) {
		return storage_results.success;
	}

	// Cancelled operation
	if (_status == SPARKLE_STATUS_CANCELLED) {
		return storage_results.cancelled;
	}

	// Return value
	return storage_results.failed;
}
