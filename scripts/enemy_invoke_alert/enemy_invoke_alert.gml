function enemy_invoke_alert(_hor_offset=10, _ver_offset=20) {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// FX
	var _dir = sign(image_xscale);
	vfx_create(x + _hor_offset * _dir, y - _ver_offset, obj_enemy_alert, {
		dir: _dir,
		hor_offset: _hor_offset,
		ver_offset: _ver_offset,
	}, true);
}
