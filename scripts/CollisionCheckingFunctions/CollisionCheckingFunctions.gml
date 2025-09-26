/// @description Checks if the given instance intersects a rectangle centered on the calling instance.
/// @param {Real} xrad Distance to extend the rectangle horizontally on both ends.
/// @param {Real} yrad Distance to extend the rectangle vertically on both ends.
/// @param {Bool} invert Whether or not xrad and yrad should be swapped.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Id.Instance}
function collision_box(xrad, yrad, invert, obj)
{
	var x_int = x div 1;
	var y_int = y div 1;
	
	return (invert) ?
		collision_rectangle(x_int - yrad, y_int - xrad, x_int + yrad, y_int + xrad, obj, true, false) :
		collision_rectangle(x_int - xrad, y_int - yrad, x_int + xrad, y_int + yrad, obj, true, false);
}

/// @description Checks if the given instance intersects a rectangle whose top edge is centered on the calling instance.
/// @param {Real} xrad Distance to extend the rectangle horizontally on both ends.
/// @param {Real} ylen Distance to extend the rectangle vertically.
/// @param {Real} rot Angle to rotate the rectangle.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Id.Instance}
function collision_box_vertical(xrad, ylen, rot, obj)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(rot);
	var cosine = dcos(rot);
	
	var x1 = x_int - (cosine * xrad);
	var y1 = y_int + (sine * xrad);
	var x2 = x_int + (cosine * xrad) + (sine * ylen);
	var y2 = y_int - (sine * xrad) + (cosine * ylen);
	
	return collision_rectangle(x1, y1, x2, y2, obj, true, false);
}

/// @description Checks if the given instance intersects a line from the calling instance's center point.
/// @param {Real} xrad Distance to extend the line horizontally on both ends.
/// @param {Real} yoff Distance to offset the line vertically.
/// @param {Bool} rot Angle to rotate the line.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Id.Instance}
function collision_ray(xrad, yoff, rot, obj)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(rot);
	var cosine = dcos(rot);
	
	var x1 = x_int - (cosine * xrad) + (sine * yoff);
	var y1 = y_int + (sine * xrad) + (cosine * yoff);
	var x2 = x_int + (cosine * xrad) + (sine * yoff);
	var y2 = y_int - (sine * xrad) + (cosine * yoff);
	
	return collision_line(x1, y1, x2, y2, obj, true, false);
}

/// @description Checks if the given instance intersects a line from the calling instance's center point.
/// @param {Real} xoff Distance to offset the line horizontally.
/// @param {Real} ylen Distance to extend the line vertically.
/// @param {Bool} rot Angle to rotate the line.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Id.Instance}
function collision_ray_vertical(xoff, ylen, rot, obj)
{
	var x_int = x div 1;
	var y_int = y div 1;
	var sine = dsin(rot);
	var cosine = dcos(rot);
	
	var x1 = x_int + (cosine * xoff);
	var y1 = y_int - (sine * xoff);
	var x2 = x_int + (cosine * xoff) + (sine * ylen);
	var y2 = y_int - (sine * xoff) + (cosine * ylen);
	
	return collision_line(x1, y1, x2, y2, obj, true, false);
}