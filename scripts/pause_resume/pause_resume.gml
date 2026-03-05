function pause_resume() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// SFX
	audio_play_sfx(snd_menu_confirm, 2);
	audio_play_sfx(snd_pause_stop, 2);
			
	// Go back to the level
	room_goto(paused_room);
	audio_resume_all();

	// Variables
	surface_free(pause_surface);
	pause_surface = noone;
	in_process = false;
	alarm_set(0, 15);
}
