// Variables
commands = dev_setup_commands();
show_masks = true;
show_player_strip = true;
show_enemy_strips = false;
readout = {
	hor_speed: 0,
	ver_speed: 0,
	angle: 0,
	mask_direction: 0,
	gravity_direction: 0,
	ground_lock: 0,
	air_lock: 0,
	plane: 0,
	state_previous: "",
	state: "",
	sprite: "",
};

// Show overlay
show_debug_overlay(true, true, 1, 0.8);

// Show the panel
view = dbg_view("Blue Blur Dev", true);

dbg_section("Player");
var _fields = [
	["hor_speed", "HSPEED"],
	["ver_speed", "VSPEED"],
	["angle", "ANGLE"],
	["mask_direction", "MASK DIR"],
	["gravity_direction", "GRAVITY DIR"],
	["ground_lock", "GROUND LOCK"],
	["air_lock", "AIR LOCK"],
	["plane", "PLANE"],
	["state_previous", "OLD STATE"],
	["state", "NEW STATE"],
	["sprite", "ANIMATION"],
];
for (var _i = 0; _i < array_length(_fields); _i++) {
	dbg_watch(ref_create(readout, _fields[_i][0]), _fields[_i][1]);
}

dbg_section("Draw");
dbg_checkbox(ref_create(self, "show_masks"), "Collision masks");
dbg_checkbox(ref_create(self, "show_player_strip"), "Player frames");
dbg_checkbox(ref_create(self, "show_enemy_strips"), "Enemy frames");

dbg_section("Commands");
for (var _i = 0; _i < array_length(commands); _i++) {
	var _command = commands[_i];
	// The keys are function keys, which are numbered in order
	var _key_name = "F" + string(_command.key - vk_f1 + 1);
	var _hint = _command.shift ? "Shift+" + _key_name : _key_name;
	dbg_button(_command.label + " (" + _hint + ")", method({ command: _command }, function() {
		dev_run_command(command);
	}));
}
