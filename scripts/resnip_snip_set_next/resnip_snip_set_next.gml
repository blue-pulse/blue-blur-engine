/// @func resnip_snip_set_next(snip, next, [options])
/// @desc Sets the snip that plays after this one completes, and how it plays. It is the only change allowed to a snip, and only during setup, because a snip cannot name another snip that does not exist yet as in A to B to A. It replaces the successor of AESnips, with its transition setting and its direction.
/// @param {Struct} snip The snip to change
/// @param {Struct} next The snip to play after it, or undefined for none
/// @param {Struct} [options] Optional fields: transition (look for a transition from this snip, default true) and backward (play it from its last frame down, default false)
function resnip_snip_set_next(_snip, _next, _options = {}) {
	if (_next != undefined && !is_struct(_next)) {
		__resnip_error("resnip_snip_set_next received a next that is not a snip. Pass the result of resnip_snip_create, or undefined for none.");
	}
	if (!is_struct(_options)) {
		__resnip_error("resnip_snip_set_next received options that are not a struct. Pass {transition, backward}.");
	}
	_snip.next = _next;
	_snip.next_transition = _options[$ "transition"] ?? true;
	_snip.next_backward = _options[$ "backward"] ?? false;
	_snip.__options.next = _next;
	_snip.__options.next_options = __resnip_options_merge({}, _options);
}
