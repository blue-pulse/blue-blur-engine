// Destroy if impacted
if (impacted) {
	instance_destroy();
	exit;
}

// Destroy if offscreen
if (!in_view(id, cull.offset)) {
	instance_terminate();
}
