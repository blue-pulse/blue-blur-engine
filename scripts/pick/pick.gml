function pick() {
	return argument[(max(0, argument[0]) mod (argument_count - 1)) + 1];
}
