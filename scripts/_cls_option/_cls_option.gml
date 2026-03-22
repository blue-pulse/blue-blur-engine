function cls_option(_sprite, _x, _y, _text="") constructor {
	// Variables
    sprite = _sprite;
    state = 0;
	x = _x;
	y = _y;
	text = _text;
	
	// Set state
	function set_state(_state) {
        state = _state;
    }

	// Draw
	function draw() {
        draw_sprite(sprite, state, x, y);
    }
}
