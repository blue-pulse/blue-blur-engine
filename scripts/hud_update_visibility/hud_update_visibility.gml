function hud_update_visibility(has_timer, has_rings, has_stamina, has_life) {
	with (obj_hud) {
		timer.display = has_timer;
		rings.display = has_rings;
		stamina.display = has_stamina;
		life.display = has_life;
	}
}
