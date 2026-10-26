/// @func resnip_transition_add(from, to, use, [backward])
/// @desc Registers a snip that plays between two others when a playback is told to play one while it plays the other with the transition option. A second call for the same pair replaces the first. The registry holds the snips until resnip_transition_remove is called. It has no native equivalent. It replaces the Transition of AESnips, and the backward option replaces its reverse clone.
/// @param {Struct} from The snip that is playing
/// @param {Struct} to The snip that is asked for
/// @param {Struct} use The snip that plays in between
/// @param {Bool} [backward] Whether the use snip plays backward, which lets one authored snip serve both ways (default false)
/// @returns {Struct} The registered transition
function resnip_transition_add(_from, _to, _use, _backward = false) {
	var _transition = { from: _from, to: _to, use: _use, backward: _backward };
	__resnip_system().transitions[$ __resnip_transition_key(_from, _to)] = _transition;
	return _transition;
}
