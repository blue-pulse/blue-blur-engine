function angle_rotate(src, dest, rot_speed) {
    var angle_diff = cycle(dest - src, -180, 180);
    if (angle_diff < -rot_speed) then return (src - rot_speed);
	if (angle_diff > rot_speed) then return (src + rot_speed);
	return dest;
}
