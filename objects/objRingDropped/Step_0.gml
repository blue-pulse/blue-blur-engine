/// @description Movement and collision
var sine = dsin(gravity_direction);
var cosine = dcos(gravity_direction);

// Move horizontally
var ox = cosine * hor_speed;
var oy = sine * hor_speed;
x += ox;
y -= oy;

// Bounce, if not previously in collision
if (place_meeting(x + ox, y - oy, obj_solid) and not place_meeting(xprevious, yprevious, obj_solid))
{
	// Move outside of collision
	while (place_meeting(x, y, obj_solid))
	{
		x -= sign(ox);
		y += sign(oy);
	}
	hor_speed *= -0.25;
}

// Move vertically
ox = sine * ver_speed;
oy = cosine * ver_speed;
x += ox;
y += oy;

// Bounce, if not previously in collision
if (place_meeting(x + ox, y + oy, obj_solid) and not place_meeting(xprevious, yprevious, obj_solid))
{
	// Move outside of collision
	while (place_meeting(x, y, obj_solid))
	{
		x -= sign(ox);
		y -= sign(oy);
	}
	ver_speed *= -0.75;
}

// Gravity
ver_speed += grav_force;