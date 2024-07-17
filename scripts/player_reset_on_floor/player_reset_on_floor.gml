function player_reset_on_floor() {
    // Wait until player has landed
    if (is_grounded) {
        if (!on_object and (state != states.idle)) {
            if (state != states.spindash) {
                state = states.moving;
            }

            // Reset flags
            if (is_being_hurt) {
                is_being_hurt = false;
                gnd_speed = 0;
            }
            is_rolling = false;
            is_jumping = false;
            air_lock = false;
            is_pushing = false;

            // Update visual angle if floor is steep enough
            if (angle >= 35.16 and angle <= 324.84) {
                rotation = angle;
            }

            // Reset gravity
            if (!is_underwater) {
                gravity_force = 0.21875;
            } else {
                // Reduce by 0.15625 if underwater
                gravity_force = 0.0625
            }

            // Reset collision radiuses if not rolling
            if (!is_rolling) {
                pos_y -= default_radius_y - radius_y;
                radius_x = default_radius_x;
                radius_y = default_radius_y;
            }
        }
    }
}
