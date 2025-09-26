/// @description Movement and collision
var sine = dsin(gravity_direction);
var cosine = dcos(gravity_direction);

// Move horizontally
var ox = cosine * x_speed;
var oy = sine * x_speed;
x += ox;
y -= oy;

// Bounce, if not previously in collision
if (place_meeting(x + ox, y - oy, objSolid) and not place_meeting(xprevious, yprevious, objSolid))
{
	// Move outside of collision
	while (place_meeting(x, y, objSolid))
	{
		x -= sign(ox);
		y += sign(oy);
	}
	x_speed *= -0.25;
}

// Move vertically
ox = sine * y_speed;
oy = cosine * y_speed;
x += ox;
y += oy;

// Bounce, if not previously in collision
if (place_meeting(x + ox, y + oy, objSolid) and not place_meeting(xprevious, yprevious, objSolid))
{
	// Move outside of collision
	while (place_meeting(x, y, objSolid))
	{
		x -= sign(ox);
		y -= sign(oy);
	}
	y_speed *= -0.75;
}

// Gravity
y_speed += gravity_force;