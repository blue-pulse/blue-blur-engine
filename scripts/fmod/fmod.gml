function fmod(a, b) {
	if (b == 0) {
		return NaN;
	}
    return a - trunc(a / b) * b;
}
