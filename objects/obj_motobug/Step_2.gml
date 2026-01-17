/// @description Smoke trail
if (hspeed != 0 and global.framecount mod 16 == 0)
{
	part_particles_create(global.particles, x - 24 * image_xscale, y, global.motobug_smoke, 1);
}