// Feather disable all

//This script contains the default profiles, and hence the default bindings and verbs, for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The struct return by this script contains the names of each default profile.
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by calling one of the input_binding_*()
//functions, such as input_binding_key() for keyboard keys and input_binding_mouse() for
//mouse buttons

function __input_config_verbs() {
	return {
		keyboard_and_mouse: {
			btn_up: input_binding_key(vk_up),
			btn_down: input_binding_key(vk_down),
			btn_left: input_binding_key(vk_left),
			btn_right: input_binding_key(vk_right),
			btn_enter: input_binding_key(vk_enter),
			btn_1: input_binding_key(vk_space),
			btn_2: input_binding_key("X"),
			btn_3: input_binding_key("Z"),
			btn_4: input_binding_key("C")
		},
		gamepad: {
			btn_up: [input_binding_gamepad_button(gp_padu), input_binding_gamepad_axis(gp_axislv, true)],
			btn_down: [input_binding_gamepad_button(gp_padd), input_binding_gamepad_axis(gp_axislv, false)],
			btn_left: [input_binding_gamepad_button(gp_padl), input_binding_gamepad_axis(gp_axislh, true)],
			btn_right: [input_binding_gamepad_button(gp_padr), input_binding_gamepad_axis(gp_axislh, false)],
			btn_enter: input_binding_gamepad_button(gp_start),
			btn_1: input_binding_gamepad_button(gp_face1),
			btn_2: input_binding_gamepad_button(gp_face2),
			btn_3: input_binding_gamepad_button(gp_face3),
			btn_4: input_binding_gamepad_button(gp_face4)
		}
	};
}
