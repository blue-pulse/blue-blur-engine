function player_publish_facts() {
	// Compile with the function inlined
	gml_pragma("forceinline");

	// Variables
	var facts = presentation_facts;

	// Publish what the body is doing
	facts.state = state;
	facts.ledge = cliff_dir * dir;
	facts.speed = abs(hor_speed);
	facts.spindash_revs = spindash_revs;
	facts.pushing = is_pushing;
	facts.rotation = rotation;
	facts.rolling = is_rolling;
	facts.rising = is_rising;
	facts.braking_turn = is_braking_turn;
	facts.curl_ups = curl_ups;
	facts.monitor_bounces = monitor_bounces;
}
