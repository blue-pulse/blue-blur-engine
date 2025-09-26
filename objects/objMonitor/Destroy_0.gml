/// @description Break

// Create broken base
var base = instance_create_layer(x, y, layer, objMonitorBroken);
if (not place_meeting(x, y + 1, objSolid))
{
	// Fall if not on ground
	base.vspeed = vspeed;
	base.gravity = 0.21875;
}

// Explosion
part_particles_create(objResources.particles, x, y, objResources.explosion, 1);