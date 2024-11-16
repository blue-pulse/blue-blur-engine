// Early exit
if --game_is_loading then return;
if !audio_group_is_loaded(grp_music) then return;
if !audio_group_is_loaded(grp_sfx) then return;
if !audio_group_is_loaded(grp_voices) then return;

// Start the game
print("[INFO] Starting game...");
room_goto(rm_practice_zone)//room_goto_next();