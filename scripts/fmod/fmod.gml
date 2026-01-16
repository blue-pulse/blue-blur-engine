function fmod(a, b) {
	if (b == 0) {
		return NaN;
	}
    return a - (a div b) * b;
}
