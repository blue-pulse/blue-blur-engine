// Early exit
if (--timer < 0 or !instance_exists(owner)) {
	audio_stop_sound(sfx_alert);
	instance_destroy();
	exit;
}

// Update position
x = floor(owner.x + hor_offset * dir);
y = floor(owner.y - ver_offset);
