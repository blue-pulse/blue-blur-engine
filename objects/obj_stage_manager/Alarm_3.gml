// Wait for the saves to finish
if (storage_is_busy()) {
	alarm_set(3, 1);
	exit;
}

// Restart game
framework_restart();
