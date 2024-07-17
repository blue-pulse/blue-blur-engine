function sonic_anim_moving() {
    var running_speed = abs(gnd_speed);
    if (running_speed > 0 and running_speed < 2.4) {
        sprite_index = spr_sonic_strolling;
        image_speed = clamp(running_speed, 0.67, 1);
    } else if (running_speed >= 2.4 and running_speed < 4) {
        sprite_index = spr_sonic_walking;
        image_speed = clamp(running_speed, 0.67, 1);
    } else if (running_speed >= 4 and running_speed < 6.1) {
        sprite_index = spr_sonic_jogging;
        image_speed = map(running_speed, 4, 6.1, 1, 2);
    } else if (running_speed >= 6.1 and running_speed < 10) {
        sprite_index = spr_sonic_running;
        image_speed = map(running_speed, 6.1, 10, 1.5, 2.5);
    } else if (running_speed >= 10) {
        sprite_index = spr_sonic_sprinting;
        image_speed = map(running_speed, 10, 12, 1.35, 3);
    }
}
