/// @description Initialize
image_speed = 0;

// Recorded events
current_events = [];
previous_events = [];

// Keyboard codes
keycodes =
{
	up : vk_up,
	down : vk_down,
	left : vk_left,
	right : vk_right,
	a : ord("Z"),
	b : ord("X"),
	c : ord("C"),
	start : vk_enter,
	resize : vk_f4
};

// Gamepad data
gp_device = -1;
deadzone = 0.5;
buttons = undefined;