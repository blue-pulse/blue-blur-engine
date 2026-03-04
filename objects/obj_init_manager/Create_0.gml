// Variables
is_starting = false;
skip_loading = false;

// Start game
if (room == rm_init_game) {
	is_starting = true;
	skip_loading = framework_start();
} else {
	framework_end();
}
