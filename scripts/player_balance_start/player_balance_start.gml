function player_balance_start() {
    if (gnd_speed == 0) {
        // Balance on the floor
        if (!on_object) {
            if (angle >= 46.41 and angle <= 313.59) {
                return;
            }

            // Check for floor
            var found_floor = tile_find_v(pos_x, pos_y + radius_y, true, plane)[0];
            if (found_floor < 12) {
                return;
            }

            // Get floor angles and continue if only one exists
            var found_angle_1 = tile_find_v(pos_x - radius_x, pos_y + radius_y, true, plane)[1];
            var found_angle_2 = tile_find_v(pos_x + radius_x, pos_y + radius_y, true, plane)[1];

            if !(found_angle_1 and !found_angle_2 or !found_angle_1 and found_angle_2) {
                return;
            }

            // Balance!
            if (!found_angle_1) {
                player_balance_left(tile_find_v(pos_x + 6, pos_y + radius_y, true, plane)[0] >= 12);
            } else if (!found_angle_2) {
                player_balance_right(tile_find_v(pos_x - 6, pos_y + radius_y, true, plane)[0] >= 12);
            }
        } else {
            // Balance on objects
            var tolerance = 2;

            // Ignore specific objects
            if (on_object.object_index == obj_bridge) {
                return;
            }

            // Get balance range
            var player_x = on_object.solid_x - on_object.x + floor(pos_x);
            var right_edge = on_object.solid_x * 2 - 1;

            // Balance
            if (player_x < tolerance) {
                player_balance_left(player_x < -tolerance);
            } else if (player_x > right_edge - tolerance) {
                player_balance_right(player_x > right_edge + tolerance);
            }
        }
    }
}
