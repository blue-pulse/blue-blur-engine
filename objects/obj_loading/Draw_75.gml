// Early exit
if (!storage_is_busy(INDICATOR_MIN_TIME)) {
	exit;
}

// Draw icon
draw_self();
