/// @description Checks if the given input event was registered this step.
/// @param {String} event Input event name.
/// @returns {Bool}
function input_check_held(event)
{
	return array_contains(objInput.current_events, event);
}

/// @description Checks if the given input event was registered this step and not last step.
/// @param {String} event Input event name.
/// @returns {Bool}
function input_check_pressed(event)
{
	return (array_contains(objInput.current_events, event) and not array_contains(objInput.previous_events, event));
}

/// @description Checks if the given input event was registered last step and not this step.
/// @param {String} event Input event name.
/// @returns {Bool}
function input_check_released(event)
{
	return (not array_contains(objInput.current_events, event) and array_contains(objInput.previous_events, event));
}