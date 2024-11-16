function enemy_destroy_badnik() {
	// Increase player score
	global.score += 300;
	
	// VFX
	instance_create_vfx(x, y, obj_explosion_small, true);
	instance_create_vfx(x, y, obj_energy_orb, true);
	
	// SFX
	var hit_sfx = array_rand(snd_hit);
	audio_play_sound(hit_sfx, queue.sfx, false);
	audio_play_sound(snd_enemy_blast_a, queue.sfx, false);
	
	// Destroy enemy
	instance_destroy();
}
