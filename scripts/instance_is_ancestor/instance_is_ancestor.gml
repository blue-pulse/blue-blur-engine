/// Returns whether an instance is a descendant of an object, which is not the case when it is an instance of that object itself.
/// @param {Id.Instance} child Instance to check
/// @param {Asset.GMObject} parent Object that may be an ancestor
function instance_is_ancestor(_child, _parent) {
	return object_is_ancestor(_child.object_index, _parent);
}
