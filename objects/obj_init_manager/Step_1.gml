// Early exit
if !audio_group_is_loaded(grp_bgm) then return;
if !audio_group_is_loaded(grp_sfx) then return;
if !audio_group_is_loaded(grp_voices) then return;

// Start the game
room_fadeto(rm_title, 15, c_white);
