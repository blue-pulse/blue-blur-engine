// Early exit if not in view
if (!in_view(id, CULL_OFFSET)) {
	instance_destroy();
	exit;
}

// Variables
var sine = dsin(gravity_direction);
var cosine = dcos(gravity_direction);

// Move horizontally
var pos_x = cosine * hor_speed;
var pos_y = sine * hor_speed;
x += pos_x;
y -= pos_y;

// Bounce
if (place_meeting(x + pos_x, y - pos_y, obj_solid) and !place_meeting(xprevious, yprevious, obj_solid)) {
	hor_speed *= -0.75;
	while (place_meeting(x, y, obj_solid)) {
		x -= sign(pos_x);
		y += sign(pos_y);
	}
}

// Move vertically
pos_x = sine * ver_speed;
pos_y = cosine * ver_speed;
x += pos_x;
y += pos_y;

// Bounce
if (place_meeting(x + pos_x, y + pos_y, obj_solid) and !place_meeting(xprevious, yprevious, obj_solid)) {
	ver_speed *= -0.75;
	while (place_meeting(x, y, obj_solid)) {
		x -= sign(pos_x);
		y -= sign(pos_y);
	}
}
ver_speed += grav_force;

// Destroy when timer runs out
if (--timer <= 0) {
	instance_destroy();
}

// Disintegrate
else if (timer <= 16) {
	image_alpha -= 0.05;
}
