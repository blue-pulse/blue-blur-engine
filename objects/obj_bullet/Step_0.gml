// Destroy if impacted
if (impacted) {
	instance_destroy();
	exit;
}

// Destroy if offscreen
if (!in_view(id, CULL_OFFSET)) {
	instance_terminate();
}
