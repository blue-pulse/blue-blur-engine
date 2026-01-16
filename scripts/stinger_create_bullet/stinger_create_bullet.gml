function stinger_create_bullet() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	return vfx_create(x + 12 * dir, y + 12, obj_stinger_bullet, {
		image_xscale: dir,
		hspeed: 1.5 * dir,
		vspeed: 1.5,
	});
}
