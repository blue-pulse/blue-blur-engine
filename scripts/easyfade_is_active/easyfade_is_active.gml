/// Returns whether a fade is in progress.
function easyfade_is_active() {
	return instance_exists(__easyfade_controller);
}
