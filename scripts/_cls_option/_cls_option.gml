function cls_option(_sprite) constructor {
	// Variables
    sprite = _sprite;
    state = 0;
	
	// Set state
	function set_state(_state) {
        state = _state;
    }
	
	// Draw
	function draw(_x, _y) {
        draw_sprite(sprite, state, _x, _y);
    }
}
