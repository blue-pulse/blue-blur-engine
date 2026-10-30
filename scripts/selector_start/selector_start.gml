function selector_start(facts, params) {
	// Early exit
	if (animation_is_playing(params.clip)) {
		exit;
	}

	// Play at the pace the fact asks for
	var pace = params.pace.map;
	animation_play(params.clip, map(facts[$ params.fact], pace[0], pace[1], pace[2], pace[3]));

	// Attach the effect, which lives while the animation plays
	var effect = params[$ "effect"];
	if (effect != undefined) {
		vfx_create(x, y, effect.object, { angle: facts.rotation, hook: params.clip, sprite: effect.sprite });
	}
}
