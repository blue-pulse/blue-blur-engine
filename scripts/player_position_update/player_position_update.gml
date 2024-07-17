function player_position_update() {
    // Position
    pos_x += hor_speed;
    pos_y += ver_speed;

    // Vertical speed while airborne
    if (!is_grounded) {
        ver_speed += gravity_force;
    }
}
