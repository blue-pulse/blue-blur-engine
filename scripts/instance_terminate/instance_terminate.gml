/// Destroys the calling instance without running its Destroy event, unlike instance_destroy.
function instance_terminate() {
	instance_destroy(id, false);
}
