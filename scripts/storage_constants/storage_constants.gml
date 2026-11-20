// Results of an operation
enum storage_results {
	success,
	failed,
	cancelled,
}

// Time the storage stays active after its last operation, in milliseconds
#macro STORAGE_ACTIVE_TIME 1200
