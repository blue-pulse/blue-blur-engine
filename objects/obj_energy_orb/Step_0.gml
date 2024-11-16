if (point_in_hitbox(x, y, Player.hitbox)) {
	Player.stamina += 7;
	audio_play_sfx(snd_player_energy_orb);
	instance_destroy();
} else {
	// Go to player
	abs_speed += 0.5;
	move_towards_point(Player.x, Player.y, abs_speed);
	
	// Create particle
	var angle = point_direction(xprevious, yprevious, x, y);
	part_type_direction(energy_particle, angle, angle, 0, 0);
	part_particles_create(part_sys, x, y, energy_particle, 2);
}
