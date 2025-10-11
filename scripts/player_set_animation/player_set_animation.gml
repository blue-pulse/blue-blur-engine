function player_set_animation(anim, allow_transition=true) {
	animation = anim;
	return snip_play_request(anim, allow_transition);
}
