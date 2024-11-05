if (!Player.is_being_hurt and Player.invincibility_frames < 90) {
	if (instance_check_collision(hitbox, Player.hitbox)) {
		// Increase player's rings
		Player.rings += value;
		
		// Effects
		var snd_clip = get_sfx();
		audio_play_sfx(snd_clip);
		instance_create_vfx(x, y, obj_ring_spark, true);
		
		// Destroy object
		instance_destroy();
	}
}
