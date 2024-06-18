if (input_check("btn_right")) {
	facing = right;
	horizontal_speed += 1;
	set_state(moving);
} else if (input_check("btn_left")) {
	facing = left;
	horizontal_speed -= 1;
	set_state(moving);
} else {
	set_state(idle);
	horizontal_speed = 0;
}

run_state();