function scene_change(_room, _duration=60, _color=c_black, _fade_audio=false) {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Fade to the room
	easyfade_to_room(_room, _duration, _color, _fade_audio);
}
