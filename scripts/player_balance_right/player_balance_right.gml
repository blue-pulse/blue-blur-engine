function player_balance_right(panic_condition) {
    if (facing == RIGHT) {
        state = states.balancing;
    } else if (facing == LEFT) {
        state = states.balancing_flip;
    }

    if (panic_condition) {
        if (facing == LEFT) {
            state = states.balancing_turn;
            facing = RIGHT;
        } else {
            state = states.balancing_panic;
        }
    }
}
