/// @func resnip_snip_clone(snip, [overrides])
/// @desc Creates a new snip from the options of another one, with some options replaced. Loops get new identities, so a repeat count set on a playback for the original does not apply to the clone. Transitions are not copied, so add them again. It has no native equivalent. It replaces snip_clone, snip_clone_loops and snip_clone_transitions of AESnips.
/// @param {Struct} snip The snip to copy
/// @param {Struct} [overrides] Options to replace, with the same fields as resnip_snip_create plus sprite
/// @returns {Struct} The new snip
function resnip_snip_clone(_snip, _overrides = {}) {
	var _sprite = _overrides[$ "sprite"] ?? _snip.sprite;
	return resnip_snip_create(_sprite, __resnip_options_merge(_snip.__options, _overrides));
}
