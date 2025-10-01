/// @description Fades out from the current room and into the given room.
/// @param {Asset.GMRoom} target_room Room to switch to.
/// @param {Real} [steps] Transition length in steps (default 24.)
function transition_to(target_room, steps = 24) {
	room_fadeto(target_room, steps)
}

/// @description Initialize game
function start_engine() {
	surface_depth_disable(true);
	randomize();

	// Screen / camera macros
	#macro SCREEN_WIDTH 400
	#macro SCREEN_HEIGHT 224
	#macro CAMERA_ID view_camera[0]
	#macro CAMERA_PADDING 64

	// Shape macros
	#macro SHP_RECTANGLE 0
	#macro SHP_RIGHT_TRIANGLE 1
	#macro SHP_QUARTER_PIPE 2
	#macro SHP_QUARTER_ELLIPSE 3
	#macro SHP_CUSTOM 4

	// Reaction macros
	#macro DIR_LEFT -1
	#macro DIR_RIGHT 1
	#macro DIR_TOP -2
	#macro DIR_BOTTOM 2

	// Create global controllers
	instance_create_layer(0, 0, "Instances", objAudio);

	// Start game
	room_fadeto(rm_test_zone);
}
