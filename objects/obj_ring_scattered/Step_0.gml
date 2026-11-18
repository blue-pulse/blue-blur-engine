// Early exit if not in view
if (!in_view(id, 24)) {
	instance_destroy();
	exit;
}

// Variables
var _sine = dsin(gravity_direction);
var _cosine = dcos(gravity_direction);

// Move horizontally
var _pos_x = _cosine * hor_speed;
var _pos_y = _sine * hor_speed;
x += _pos_x;
y -= _pos_y;

// Bounce
if (place_meeting(x + _pos_x, y - _pos_y, obj_solid) and !place_meeting(xprevious, yprevious, obj_solid)) {
	hor_speed *= -0.75;
	while (place_meeting(x, y, obj_solid)) {
		x -= sign(_pos_x);
		y += sign(_pos_y);
	}
}

// Move vertically
_pos_x = _sine * ver_speed;
_pos_y = _cosine * ver_speed;
x += _pos_x;
y += _pos_y;

// Bounce
if (place_meeting(x + _pos_x, y + _pos_y, obj_solid) and !place_meeting(xprevious, yprevious, obj_solid)) {
	ver_speed *= -0.75;
	while (place_meeting(x, y, obj_solid)) {
		x -= sign(_pos_x);
		y -= sign(_pos_y);
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
