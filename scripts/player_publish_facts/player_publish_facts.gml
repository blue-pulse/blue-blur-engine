function player_publish_facts() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Publish what the body is doing
	presentation_facts.state = state;
	presentation_facts.ledge = cliff_dir * dir;
	presentation_facts.speed = abs(hor_speed);
	presentation_facts.spindash_revs = spindash_revs;
	presentation_facts.pushing = is_pushing;
	presentation_facts.rotation = rotation;
	presentation_facts.rolling = is_rolling;
	presentation_facts.rising = is_rising;
	presentation_facts.braking_turn = is_braking_turn;
	presentation_facts.curl_ups = curl_ups;
	presentation_facts.monitor_bounces = monitor_bounces;
}
