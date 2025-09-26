/// @description Smoke trail
if (hspeed != 0 and objScreen.image_index mod 16 == 0)
{
	part_particles_create(objResources.particles, x - 24 * image_xscale, y, objResources.motobug_smoke, 1);
}