function file_save_userdata() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// Early exit
	var slot = global.slot;
	if (!slot) {
		print("[ERROR] An invalid slot was received!");
		print("[WARN] No data will be saved.");
		exit;
	}

	// Save current slot
	global.last_slot = slot;
	ssave_get(cls_config)
		.set("last", slot)
		.save();

	// Save player progress
	Files.Save(slot);
}
