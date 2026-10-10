/// Deletes a buffer only if it exists, so deleting a buffer twice does not raise an error unlike buffer_delete.
/// @param {Id.Buffer} buffer Buffer to delete
function buffer_destroy(_buffer) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Logic
	if (buffer_exists(_buffer)) {
		buffer_delete(_buffer);
	}
}
