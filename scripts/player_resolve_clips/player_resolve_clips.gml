function player_resolve_clips(_clips) {
	// Variables
	var fallbacks = player_define_fallbacks();
	var names = struct_get_names(fallbacks);
	var count = array_length(names);
	var character = object_get_name(object_index);

	// Give each missing clip the first clip that its fallbacks lead to
	for (var i = 0; i < count; i++) {
		var name = names[i];
		if (struct_exists(_clips, name)) {
			continue;
		}
		var source = fallbacks[$ name];
		for (var step = 0; step < count and !struct_exists(_clips, source) and struct_exists(fallbacks, source); step++) {
			source = fallbacks[$ source];
		}
		if (struct_exists(_clips, source)) {
			_clips[$ name] = _clips[$ source];
			print("[WARN] " + character + " has no " + name + " animation, so " + source + " plays in its place. Add it to the clips of the character to use its own.");
		} else {
			print("[ERROR] " + character + " has no " + name + " animation and nothing to play in its place. Add an idle animation to the clips of the character.");
		}
	}

	// Return value
	return _clips;
}
