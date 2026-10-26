/// @func resnip_play(playback, snip, [options])
/// @desc Plays a snip on a playback now, or queues it for when the current one completes. The queue, the target of a transition and the next of a snip all answer what plays next, in that order. It replaces setting sprite_index and image_index by hand, and it covers snip_play, snip_play_next and snip_play_request of AESnips. A transition plays in its own direction, and the snip it leads to plays in the direction asked.
/// @param {Struct} playback The playback that plays it
/// @param {Struct} snip The snip to play
/// @param {Struct} [options] Optional fields: transition (look for a transition from the current snip, default false), queue (wait for the current snip to complete, default false), restart (play even if it already plays, default true), backward (play from its last frame down, default false)
/// @returns {Bool} Whether the playback started it or queued it
function resnip_play(_playback, _snip, _options) {
	// Start now when no option is given, before any local so the VM builds no locals for it
	if (_options == undefined) {
		__resnip_playback_start(_playback, _snip, false, false, undefined);
		return true;
	}

	// Options, read only when given because a default argument costs a write on YYC
	var _transition = _options[$ "transition"] ?? false;
	var _queue = _options[$ "queue"] ?? false;
	var _restart = _options[$ "restart"] ?? true;
	var _backward = _options[$ "backward"] ?? false;

	// Prevent a restart when asked not to
	if (!_restart && ((_playback.snip == _snip && !_playback.stopped) || _playback.__target == _snip)) {
		return false;
	}

	// Queue for later
	if (_queue && _playback.snip != undefined && !_playback.stopped) {
		_playback.__queue = { snip: _snip, transition: _transition, backward: _backward };
		return true;
	}

	// Start it now
	__resnip_playback_start(_playback, _snip, _transition, _backward, undefined);
	return true;
}
