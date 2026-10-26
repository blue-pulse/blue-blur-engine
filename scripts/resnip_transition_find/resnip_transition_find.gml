/// @func resnip_transition_find(from, to)
/// @desc Returns the transition registered between two snips. It has no native equivalent.
/// @param {Struct} from The snip that is playing
/// @param {Struct} to The snip that is asked for
/// @returns {Struct} The transition, or undefined if there is none
function resnip_transition_find(_from, _to) {
	return __resnip_system().transitions[$ __resnip_transition_key(_from, _to)];
}
