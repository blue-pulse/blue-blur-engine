function __resnip_playback_give_up(_playback) {
	show_debug_message("[WARNING] A playback holds its last frame because loops with a count below 0 skip every frame of its snip. Give a loop a count of 0 or above, or leave a frame outside the loops.");
	_playback.frame = (_playback.direction > 0) ? _playback.snip.count - 1 : 0;
	_playback.stopped = true;
}
