function selector_start(_facts, _params) {
	// Early exit
	if (animation_is_playing(_params.clip)) {
		exit;
	}

	// Play at the pace the fact asks for
	var _pace = _params.pace.map;
	animation_play(_params.clip, map(_facts[$ _params.fact], _pace[0], _pace[1], _pace[2], _pace[3]));

	// Attach the effect, which lives while the animation plays
	var _effect = _params[$ "effect"];
	if (_effect != undefined) {
		vfx_create(x, y, _effect.object, { angle: _facts.rotation, hook: _params.clip, sprite: _effect.sprite });
	}
}
