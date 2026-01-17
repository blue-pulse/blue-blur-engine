function angle_approach(src, dest, increment) {  
    var diff = fmod(dest - src + 540, 360) - 180;
    if (diff > 0) {
		return fmod(src + min(diff, increment), 360);
	}
	return fmod(360 - fmod(360 - (src + max(-increment, diff)), 360), 360);
}
