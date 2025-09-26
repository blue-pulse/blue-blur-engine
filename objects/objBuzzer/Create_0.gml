/// @description Initialize
event_inherited();
mask_index = sprBuzzerFly; // This defaults to "same as sprite" in object properties, so it's set here
image_speed = 0.25;

// Movement and timing
hspeed = 1.5;
turn_time = 0;
shoot_time = 0;
can_shoot = true;