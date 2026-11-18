function camera_set_target(_target) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Logic
	obj_camera.target = _target;
}
