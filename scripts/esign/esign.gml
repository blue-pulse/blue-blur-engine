function esign(value, fallback) {
	if (value == 0) {
		return fallback;
	}
	if (value > 0) {
		return 1;
	}
	return -1;
}
