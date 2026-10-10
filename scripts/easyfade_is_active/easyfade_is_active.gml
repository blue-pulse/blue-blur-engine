/// Returns whether a fade is in progress.
function easyfade_is_active() {
	return __easyfade_find_controller() != noone;
}
