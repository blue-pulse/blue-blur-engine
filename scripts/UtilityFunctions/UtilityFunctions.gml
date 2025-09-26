/// @description Wraps the given angle between 0 and 359 degrees inclusive.
/// @param {Real} value Angle to wrap.
/// @returns {Real}
function angle_wrap(value)
{
	return ((value mod 360) + 360) mod 360;
}

/// @description Checks if the given instance's coordinates lie within the current view.
/// @param {Real} obj Object or instance to check.
/// @param {Real} padding Distance to extend the view on all ends.
/// @returns {Bool}
function in_view(obj, padding)
{
	// Get view dimensions
	var view_left = camera_get_view_x(CAMERA_ID) - padding;
	var view_top = camera_get_view_y(CAMERA_ID) - padding;
	var view_right = view_left + SCREEN_WIDTH + padding * 2;
	var view_bottom = view_top + SCREEN_HEIGHT + padding * 2;
	
	// Evaluate
	with (obj) return point_in_rectangle(x, y, view_left, view_top, view_right, view_bottom);
}

/// @description Fades out from the current room and into the given room.
/// @param {Asset.GMRoom} target_room Room to switch to.
/// @param {Real} [steps] Transition length in steps (default 24.)
function transition_to(target_room, steps = 24)
{
	// Abort if already transitioning
	if (instance_exists(objTransition)) exit;
	
	// Fade out music
	with (objAudio)
	{
		alarm[0] = -1; // Stop music fade-in if a jingle is playing
		if (music != -1) audio_sound_gain(music, 0, steps * (1000 / 60));
	}
	
	// Transition
	with (instance_create_depth(0, 0, -100, objTransition))
	{
		self.target_room = target_room;
		image_speed = 1 / steps;
	}
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
	instance_create_layer(0, 0, "Instances", objInput);
	instance_create_layer(0, 0, "Instances", objScreen);
	instance_create_layer(0, 0, "Instances", objAudio);
	instance_create_layer(0, 0, "Instances", objResources);
	instance_create_layer(0, 0, "Instances", objGameData);

	// Start game
	transition_to(rm_test_zone);
}
