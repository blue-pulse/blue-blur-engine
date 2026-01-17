// Fonts

function start_engine() {
	surface_depth_disable(true);
	randomize();

	// Screen / camera macros
	#macro SCREEN_WIDTH 400
	#macro SCREEN_HEIGHT 224
	#macro CAMERA_ID view_camera[0]
	#macro CAMERA_PADDING 64

	// Reaction macros
	#macro DIR_LEFT -1
	#macro DIR_RIGHT 1
	#macro DIR_TOP -2
	#macro DIR_BOTTOM 2
	
	// Start game
	room_fadeto(rm_test_zone);
}
