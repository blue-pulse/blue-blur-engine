function presentation_update() {
	// Variables
	var facts = presentation_facts;
	var entering = facts.state != presentation_seen;

	// Find the row of a new mode
	if (entering) {
		presentation_seen = facts.state;
		presentation_row = undefined;
		var rows = presentation_set.rows;
		for (var i = 0; i < array_length(rows); i++) {
			if (rows[i].state == facts.state) {
				presentation_row = rows[i];
				break;
			}
		}
	}

	// Early exit
	var row = presentation_row;
	if (row == undefined) {
		exit;
	}

	// Choose when the mode starts, calling through a variable keeps this instance as self
	var entry = row[$ "entry"];
	for (var i = 0; entering and entry != undefined and i < array_length(entry); i++) {
		var select = entry[i].run;
		select(facts, entry[i]);
	}

	// React while the mode lasts, in the order of the row
	var follow = row[$ "follow"];
	for (var i = 0; follow != undefined and i < array_length(follow); i++) {
		var react = follow[i].run;
		react(facts, follow[i], entering);
	}
}
