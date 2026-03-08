function pause_resume() {
	// Compile with the function inlined
	gml_pragma("forceinline");
	
	// SFX
	audio_play_sfx(snd_menu_confirm, REPLACE);
	audio_play_sfx(snd_pause_stop, REPLACE);
			
	// Go back to the level
	room_goto(paused_room);
	audio_resume_all();

	// Variables
	surface_free(pause_surface);
	pause_surface = noone;
	in_process = false;
	alarm_set(0, 15);
}
