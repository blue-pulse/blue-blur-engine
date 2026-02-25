// Create flame
if (--explosion_timer == 0) {
	part_particles_create(Particles, x, y, global.vfx_big_explosion, 1);
}

// Destroy metal scrap
if (image_alpha <= 0) {
	instance_destroy();
} else {
	image_alpha -= 0.01;
	image_angle += 2;
}
