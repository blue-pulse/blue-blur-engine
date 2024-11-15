function stage_background_practice() {
	// Variables
	static shift_speed = 0;
	var background = layer_get_id("background_a");
	
	shift_speed += 0.5;
	layer_x(background, shift_speed);
	layer_y(background, shift_speed);
}
