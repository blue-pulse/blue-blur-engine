function player_balance_left(panic_condition) {
    if (facing == LEFT) {
        state = states.balancing;
    } else if (facing == RIGHT) {
        state = states.balancing_flip;
    }

    if (panic_condition) {
        if (facing == RIGHT) {
            state = states.balancing_turn;
            facing = LEFT;
        } else {
            state = states.balancing_panic;
        }
    }
}
