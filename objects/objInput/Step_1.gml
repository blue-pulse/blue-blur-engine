/// @description Memorize and register
array_resize(previous_events, 0);
array_copy(previous_events, 0, current_events, 0, array_length(current_events));
array_resize(current_events, 0);

// Keyboard input
struct_foreach(keycodes, function(event, index)
{
	if (keyboard_check(index))
	{
		array_push(current_events, event);
	}
});

// Gamepad input
if (gp_device != -1)
{
	// Analog stick
	var vaxis = gamepad_axis_value(gp_device, gp_axislv);
	if (abs(vaxis) > deadzone)
	{
		array_push(current_events, (vaxis < 0) ? "up" : "down");
	}
	var haxis = gamepad_axis_value(gp_device, gp_axislh);
	if (abs(haxis) > deadzone)
	{
		array_push(current_events, (haxis < 0) ? "left" : "right");
	}
	
	// Buttons
	struct_foreach(buttons, function(event, index)
	{
		if (gamepad_button_check(gp_device, index))
		{
			array_push(current_events, event);
		}
	});
}