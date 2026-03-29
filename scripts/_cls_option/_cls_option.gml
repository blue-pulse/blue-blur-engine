function cls_option(_sprite, _x, _y, _state, _text="") constructor {
	// Variables
    sprite = _sprite;
    state = _state;
	x = _x;
	y = _y;
	alpha = 1;
	hspeed = 0;
	vspeed = 0;
	text = _text;
	
	// Draw
	function draw() {
        draw_sprite_ext(sprite, state, x, y, 1, 1, 0, c_white, alpha);
    }
}
