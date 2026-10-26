/// @func resnip_transition_remove(from, to)
/// @desc Removes the transition between two snips so the library stops holding them. It does nothing if there is none. It has no native equivalent.
/// @param {Struct} from The snip that is playing
/// @param {Struct} to The snip that is asked for
function resnip_transition_remove(_from, _to) {
	variable_struct_remove(__resnip_system().transitions, __resnip_transition_key(_from, _to));
}
