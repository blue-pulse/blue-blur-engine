/// @description Plays the given sound effect, stopping any existing instances of it.
/// @param {Asset.GMSound} soundid Sound asset to play.
/// @returns {Id.Sound}
function audio_play_sfx(soundid)
{
	audio_stop_sound(soundid);
	return audio_play_sound(soundid, 0, false, objAudio.volume_sound);
}

/// @description Plays the given music track as a jingle, muting background music until it has finished playing.
/// @param {Asset.GMSound} soundid Sound asset to play.
function audio_play_jingle(soundid)
{
	with (objAudio)
	{
		// Stop existing jingle, otherwise mute background music
		if (jingle != -1) audio_stop_sound(jingle);
		else audio_sound_gain(music, 0, 0);
		
		// Play jingle
		jingle = audio_play_sound(soundid, 2, false, volume_music);
		alarm[0] = audio_sound_length(soundid) * 60;
	}
}

/// @description Plays the given music track as background music. If a jingle is playing, the track will be muted.
///              This should not be called outside of the `audio_enqueue_bgm`/`audio_dequeue_bgm` functions.
/// @param {Asset.GMSound} soundid Sound asset to play.
/// @param {Bool} loops Whether or not the track should continuously loop.
function audio_play_bgm(soundid, loops)
{
	audio_stop_sound(music);
	music = audio_play_sound(soundid, 1, loops, volume_music * (jingle == -1));
}

/// @description Adds the given music track to the playback queue, playing it if it is at the top.
/// @param {Asset.GMSound} soundid Sound asset to add.
/// @param {Real} priority Priority value to assign to the track.
/// @param {Bool} loops Whether or not the track should continuously loop.
function audio_enqueue_bgm(soundid, priority, loops)
{
	with (objAudio)
	{
		// Add to playback queue
		if (ds_priority_find_priority(music_queue, soundid) == undefined)
		{
			ds_priority_add(music_queue, soundid, priority);
		}
		
		// Play music track, if applicable
		if (ds_priority_find_max(music_queue) == soundid)
		{
			audio_play_bgm(soundid, loops);
		}
	}
}

/// @description Removes the given music track from the playback queue. If it was at the top, the track below it is then played.
/// @param {Asset.GMSound} soundid Sound asset to remove.
/// @param {Bool} loops Whether or not the next track should continuously loop.
function audio_dequeue_bgm(soundid, loops)
{
	with (objAudio)
	{
		// Remove from playback queue
		var queue_top = ds_priority_find_max(music_queue);
		ds_priority_delete_value(music_queue, soundid);
		
		// Play the next music track, if applicable
		if (queue_top == soundid)
		{
			audio_play_bgm(ds_priority_find_max(music_queue), loops);
		}
	}
}

/* AUTHOR NOTE: the following music tracks have the following priorities:
> Stage (loops): 0.
> Invincibility (loops): 1.
> Results (doesn't loop): 2.
> Game Over (doesn't loop): 3.

Jingles (such as the 1-up fanfare) do not loop and have priority over background music.

TODO: add looping points for music. */