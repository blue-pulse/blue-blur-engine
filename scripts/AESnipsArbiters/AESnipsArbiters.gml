///@desc Useful functions for AESnip

/*
Functions here in the Arbiters script aren't completely necessary but they're very helpful
Please use these functions instead of getting or setting the variable values directly
There are a lot of exceptions if you're an experienced programmer and know what you're doing
But it's much safer to use these functions
*/

///@func snip_go_to_frame(frame, reset)
///@desc Immediately goes to the given frame in the current snip and may or may not reset loops
///@param {int} frame The frame index to go to
///@param {bool} reset_loops Whether or not to reset the loops in the current snip and play them again or not
function snip_go_to_frame(_frame, _reset)
{
	if (_frame >= ae_snip_current_snip.snip_frame_count or _frame < 0) { throw("The given frame index ["+ string(_frame) +"] is outside the bounds of the given Snip with [" + string(ae_snip_current_snip.snip_frame_count) + "] frames"); }
	
	if (_reset)
	{
		snip_reset_loops(ae_snip_current_snip);
	}
	
	//Get the first frame in the snip and subtract it
	var _start = ae_snip_current_snip.snip_frame_start;
	image_index = _frame - _start;
}

///@func snip_get_frame_speed(snip, frame)
///@desc Returns the speed for the given frame in the given Snip
///@param {Snip} snip The Snip that the frame is in
///@param {int} frame The frame to get the speed of
function snip_get_frame_speed(_snip, _frame)
{
	//Throw an error if a bad frame is given
	if (_frame >= _snip.snip_frame_count or _frame < 0) { throw("The given frame index ["+ string(_frame) +"] is outside the bounds of the given Snip with [" + string(_snip.snip_frame_count) + "] frames"); }
	
	return _snip.frame_speed[_frame];
}

///@func snip_set_frame_speed(snip, frame, speed)
///@desc Sets the given frame from the given Snip to the given speed
///@param {Snip} snip The Snip that the frame is in
///@param {int} frame The frame number to set to the given speed (not image_index)
///@param {real} speed The speed to set the given frame relative to the Snip speed (same scale as image_speed)
function snip_set_frame_speed(_snip, _frame, _speed)
{
	//Throw an error if a bad frame is given
	if (_frame >= _snip.snip_frame_count or _frame < 0) { throw("The given frame index ["+ string(_frame) +"] is outside the bounds of the given Snip with [" + string(_snip.snip_frame_count) + "] frames"); }
	if (_speed < 0) { throw("Frame Speeds must always be larger than 0. To play a Snip backwards use snip_set_backwards()"); }
	//NOTE: a Snip speed of 0.5 and a frame speed of 0.5 will result in an overall image_speed of 0.25 for the frame
	_snip.frame_speed[_frame] = _speed;
}

///@func snip_is_playing(snip, check_transition)
///@desc Returns whether or not the given snip is currently playing (or if a transition to the snip is playing depending on the second parameter)
///@param {Snip} snip The Snip to check
///@param {bool} check_transition Whether or not to check if the current Snip is transitioning to the given snip
function snip_is_playing(_snip, _target)
{
	return ((ae_snip_current_snip == _snip and !ae_snip_is_frozen) or (ae_snip_current_target == _snip and _target));
}

///@func snip_current()
///@desc Returns the snip that is currently playing (or undefined if none)
function snip_current()
{
	return ae_snip_current_snip;
}

///@func snip_set_frame_script(snip, frame, script, [argument])
///@desc Adds a script that will execute every time an snip reaches a frame (only called once when changing to a frame)
///@param {Snip} snip The snip that holds the frame to add the script
///@param {int} frame The frame to add the script to
///@param {Script} script The script to run
///@param {any} [argument] The valut of the argument to pass into the script
function snip_set_frame_script(_snip, _frame, _script, _arg)
{
	if (_frame >= _snip.snip_frame_count or _frame < 0) { throw("The given frame index ["+ string(_frame) +"] is outside the bounds of the given Snip with [" + string(_snip.snip_frame_count) + "] frames"); }
	_snip.frame_script[_frame] = _script;
	_snip.frame_script_argument[_frame] = _arg;
}

///@func snip_get_frame_script(snip, frame)
///@desc Returns the script assigned to the given snip frame
///@param {Snip} snip The snip to get the property of
function snip_get_frame_script(_snip, _frame)
{
	if (_frame >= _snip.snip_frame_count or _frame < 0) { throw("The given frame index ["+ string(_frame) +"] is outside the bounds of the given Snip with [" + string(_snip.snip_frame_count) + "] frames"); }
	return _snip.frame_script[_frame];
}

///@func snip_set_frame_script_argument(snip, frame)
///@desc Set's the value of the argument that will be passed into the given frame's script
///@param {Snip} snip The snip to get the property of
///@param {int} frame The Snip frame number (relative to the Snip, not the sprite... eg not image_index)
///@param {any} argument The value to set the frame script's argument to
function snip_set_frame_script_argument(_snip, _frame, _arg)
{
	if (_frame >= _snip.snip_frame_count or _frame < 0) { throw("The given frame index ["+ string(_frame) +"] is outside the bounds of the given Snip with [" + string(_snip.snip_frame_count) + "] frames"); }
	_snip.frame_script_argument[_frame] = _arg;
}

///@func snip_get_frame_script(snip, frame)
///@desc Returns the value of the argument assigned to the given frame
///@param {Snip} snip The snip to get the property of
///@param {int} frame The Snip frame to get the property of
function snip_get_frame_script_argument(_snip, _frame)
{
	if (_frame >= _snip.snip_frame_count or _frame < 0) { throw("The given frame index ["+ string(_frame) +"] is outside the bounds of the given Snip with [" + string(_snip.snip_frame_count) + "] frames"); }
	return _snip.frame_script_argument[_frame];
}

///@func snip_get_frame_script_list(snip)
///@desc Returnst the given snip's list of scripts (frames without scripts will have undefined as their script)
///@parm {Snip} snip The snip to get the script list of
function snip_get_frame_script_list(_snip)
{
	return _snip.frame_script;
}

///@func snip_set_sprite(snip, sprite)
///@desc Changes an snip's sprite
///@param {Snip} snip The snip to change the sprite of
///@param {Sprite} sprite The sprite to set. The sprite must at least have a sub-image count of the snip's snip_frame_end property
function snip_set_sprite(_snip, _sprite)
{
	//Changing the sprite could cause some index out of bounds errors
	//So when changing the sprite, make sure it has enough sub-images for the snip
	
	//Get the number of frames in the sprite
	_frames = sprite_get_number(_sprite);
	//If the sprite has fewer frames than the snip
	if (_frames < _snip.snip_frame_end)
	{
		throw("The Sprite given in snip_set_sprite does not have enough sub-images. Sprite sub-image count:" + string(_frames) + " Frames needed:" + string(_snip.snip_frame_end));
	}
	else
	{
		//Set the sprite
		_snip.snip_sprite = _sprite;
		
		//A value to handle the Sprite speed and speed types
		_snip.snip_speed_scale = 1;
		if (_sprite != undefined)
		{
			if (sprite_get_speed_type(_sprite) == spritespeed_framespergameframe)
			{
				_snip.snip_speed_scale = sprite_get_speed(_sprite);
			}
			else
			{
				_snip.snip_speed_scale = sprite_get_speed(_sprite) / game_get_speed(gamespeed_fps);
			}
		}
	}
}

///@func snip_get_sprite(snip)
///@desc Returns the sprite used for the snip
///@param {Snip} snip The snip to get the sprite of (or undefined if none)
function snip_get_sprite(_snip)
{
	return _snip.snip_sprite;
}

///@func snip_set_speed(snip, speed)
///@desc Sets the speed of the Snip.
///@param {Snip} snip The Snip to set the speed of
///@param {real} speed The speed to set the Snip to play at, positive values only
function snip_set_speed(_snip, _speed)
{
	//Check to make sure the speed is a positive value
	if (_speed < 0)
	{
		throw ("The speed given in snip_set_speed cannot be negative. If you want a Snip to play backwards see snip_set_backward()");
	}
	_snip.snip_speed = _speed;
}

///@func snip_get_speed(snip)
///@desc Returns the overall speed of the given snip
///@param {Snip} snip The Snip to get the speed of
function snip_get_speed(_snip)
{
	return _snip.snip_speed;
}

///@func snip_get_end_type(snip)
///@desc Returns what the Snip is set to do when it finishes as an enum: ae_snip_end... end_stop/end_repeat/end_pingpong/end_pingpong_half
///@param {Snip} snip The snip to get the end type of
function snip_get_end_type(_snip)
{
	return _snip.snip_end_type;
}

///@func snip_set_end_type(snip, end_type)
///@desc Sets the behavior for when the given Snip finishes playing and there is no animation to play next
///@param {Snip} snip The snip to set the repeat of
///@param {ae_snip_end} end_type How to behave when the Snip finishes
function snip_set_end_type(_snip, _end_type)
{
	/*
	ae_snip_end.end_stop,				//Freeze on the completed frame
	ae_snip_end.end_stop_head,		//Jump back to the first frame and freeze
	ae_snip_end.end_stop_tail,			//Jump to the last frame and freeze
	ae_snip_end.end_repeat,			//Jump back to the first frame and play again (or the last frame if it is being played backward)
	ae_snip_end.end_pingpong,		//Reverse the Snip speed, transition to the next step when it hits the first or last frame
	ae_snip_end.end_pingpong_head,	//Reverse the Snip speed, the Snip is complete when it reaches the first frame of the Snip
	ae_snip_end.end_pingpong_tail		//Reverse the Snip speed, the Snip is complete when it reaches the final frame of the Snip
	*/
	
	_snip.snip_end_type = _end_type;
}

///@func snip_set_successor(snip, successor)
///@desc When a Snip finishes playing forwards, if it has a successor it will automatically play it with or without transition
///@param {Snip} snip The Snip to change the successor of
///@param {Snip} successor The snip to play after the given snip is finished playing (use undefined or -1 to remove the successor)
///@param {bool} [use_transition] Optional whether or not to use a transition (default = true)
function snip_set_successor(_snip, _successor, _transition)
{
	//Convert -1 to undefined
	if (_successor == -1) {_successor = undefined;}
	_snip.snip_successor = _successor;
	
	//Convert undefined transition to true
	if (_transition == undefined) {_transition = true;}
	_snip.snip_successor_transition = _transition;
}
	
///@func snip_get_successor(snip)
///@desc Returns the successor to the given snip (undefined if none)
///@param {Snip} snip The Snip to get the successor of
function snip_get_successor(_snip)
{
	return _snip.snip_successor;
}


///@func snip_set_should_transition_successor(snip, transition)
///@desc Sets whether or not the Snip should try to find a transition between the given snip and its successor
///@param {Snip} snip The Snip to change the successor transition of
///@param {bool} transition Whether or not to look for a transition between the snip and its successor
function snip_set_should_transition_successor(_snip, _transition)
{
	_snip.snip_successor_transition = _transition;
}

///@func snip_get_start_index(snip)
///@desc Returns the starting sub-image index of the sprite used by the snip
///@param {Snip} snip The snip to get the property of
function snip_get_start_index(_snip)
{
	return _snip.snip_frame_start;
}

///@func snip_get_end_index(snip)
///@desc Returns the ending sub-image index of the sprite used by the snip
///@param {Snip} snip The snip to get the property of
function snip_get_end_index(_snip)
{
	return _snip.snip_frame_end;
}

///@func snip_get_frame_count(snip)
///@desc Returns the number of frames in an snip
///@param {Snip} snip The snip to get the property of
function snip_get_frame_count(_snip)
{
	return _snip.snip_frame_count;
}

///@func snip_get_frame_speed_list(snip)
///@desc Returns the list of frame speeds for the given snip
///@param {Snip} snip The snip to get the property of
function snip_get_frame_speed_list(_snip)
{
	return _snip.frame_speed;
}

///@func snip_reset_frame_speeds(snip)
///@desc Resets all frame speeds in the given snip to 1
///@param {Snip} snip The snip to get the property of
function snip_reset_frame_speeds(_snip)
{
	var _i = 0;
	repeat(_snip.snip_frame_count)
	{
		_snip.frame_speed[_i] = 1;
		_i += 1;
	}
}

///@func snip_get_loop_count(snip)
///@desc Gets the number of loops in the given snip
///@param {Snip} snip The target snip to get the loop count of
function snip_get_loop_count(_snip)
{
	return ds_list_size(_snip.snip_loops);
}

///@func snip_get_loop_list(snip)
///@desc Returns the list of Loops in a given snip
///@param {Snip} snip The snip to get the Loop list of
function snip_get_loop_list(_snip)
{
	return _snip.snip_loops;
}

///@function snip_set_completion_script(snip, script, [argument])
///@desc Sets the script that should be executed when the given snip ends
///@param {Snip} snip The snip to set the completion script of
///@param {Script} script The script to execute when the given snip ends
///@param {any} [argument] The value of argument to pass into the script
function snip_set_completion_script(_snip, _script, _arg)
{
	_snip.snip_complete_script = _script;
	_snip.snip_complete_script_argument = _arg;
}

///@function snip_get_completion_script(snip)
///@desc Returns the script that should be executed when the given snip ends (undefined if none)
///@parap {Snip} snip The snip to get the completion script of
function snip_get_completion_script(_snip)
{
	return _snip.snip_complete_script;
}

///@function snip_set_completion_script_argument(snip, argument)
///@desc Sets the value of the argument that will be passed into the Snip's completion script
///@param {Snip} snip The snip to set completion argument of
///@param {any} argument The value of the argument to pass into the script
function snip_set_completion_script_argument(_snip, _arg)
{
	_snip.snip_complete_script_argument = _arg;
}

///@function snip_get_completion_script_argument(snip)
///@desc Returns the value of the argument that will be used in the Snip's completion script
///@parap {Snip} snip The Snip to get the value of the completion argument
function snip_get_completion_script_argument(_snip)
{
	return _snip.snip_complete_script_argument;
}

///@func snip_get_transition_from(_transition)
///@desc Returns the snip that a transition is coming from
///@param {Transition} transition The transition to get the property of
function snip_get_transition_from(_transition)
{
	return _transition.snip_from;
}

///@func snip_get_transition_to(_transition)
///@desc Returns the snip that a transition is going to
///@param {Transition} transition The transition to get the property of
function snip_get_transition_to(_transition)
{
	return _transition.snip_to;
}

///@func snip_get_transition_snip(transition)
///@desc Returns the snip that a transition plays
///@param {Transition} transition The transition to get the property of
function snip_get_transition_snip(_transition)
{
	return _transition.snip_use;
}

///func snip_set_transition_from(transition, from)
///@desc Changes the given transition's from snip
///@param {Transition} transition The transition to set the property of
///@param {Snip} from The transition to set as the new from value
function snip_set_transition_from(_transition, _from)
{
	//Get the old from
	var _old_from = _transition.snip_from;
	//Change the transition's property
	_transition.snip_from = _from;
	//Add the transition to the from
	ds_list_add(_from.outgoing_transitions, _transition);
	//Remove the transition from the old from snip's outgoing list
	ds_list_delete(_old_from.outgoing_transitions, ds_list_find_index(_old_from.outgoing_transitions, _transition));
}

///func snip_set_transition_from(transition, to)
///@desc Changes the given transition's to snip
///@param {Transition} transition The transition to set the property of
///@param {Snip} to The transition to set as the new to value
function snip_set_transition_to(_transition, _to)
{
	//Get the old from
	var _old_to = _transition.snip_to;
	//Change the transition's property
	_transition.snip_to = _to;
	//Add the transition to the from
	ds_list_add(_to.incoming_transitions, _transition);
	//Remove the transition from the old from snip's outgoing list
	ds_list_delete(_old_to.incoming_transitions, ds_list_find_index(_old_to.incoming_transitions, _transition));
}

///@func snip_set_loop_repeat(loop, repeat)
///@desc Sets the repeat count of the loop to the given repeat count
///@param {Loop} loop The loop to set the repeat count of
///@param {int} repeat The number of times to repeat the loop after it plays once
function snip_set_loop_repeat(_loop, _repeat)
{
	_loop.loop_repeat = _repeat;
}

///@func snip_get_loop_repeat(loop)
///@desc Returns the number of times a loop will repeat (not counting the first time it plays)
///@param {Loop} loop The loop to get the repeat of
function snip_get_loop_repeat(_loop)
{
	return _loop.loop_repeat;
}

///@func snip_get_loop_snip(loop)
///@desc Returns the Snip that the given loop is attached to
///@param {Loop} loop The loop to get the property of
function snip_get_loop_snip(_loop)
{
	return _loop.loop_snip;
}

///@func snip_get_loop_start(loop)
///@desc Returns the starting frame of the given loop
///@param {Loop} loop The loop to get the property of
function snip_get_loop_start(_loop)
{
	return _loop.loop_start;
}

///@func snip_get_loop_end(loop)
///@desc Returns the ending frame of the given loop
///@param {Loop} loop The loop to get the property of
function snip_get_loop_end(_loop)
{
	return _loop.loop_end;
}

///@func snip_get_current_loop()
///@desc Returns the current loop that the object is currently in (undefined if not in a loop)
function snip_get_current_loop()
{
	return ae_snip_current_loop;
}

///@func snip_get_remaining_loop_performances()
///@desc Returns the number of times the current loop has left to play (0 if not in a loop)
function snip_get_remaining_loop_performances()
{
	if (ae_snip_current_loop != undefined)
	{
		//If there's not a loop currently playing then return 0
		return 0;
	}
	else
	{
		//If there is a loop then return the difference between how many times it should repeat and how many times it has played
		return ae_snip_current_loop.loop_repeat - ae_snip_loop_performances[ae_snip_current_loop_index];
	}
}

///@func snip_get_next_snip()
///@desc Returns the snip that will play after the current snip finishes (undefined if none or if the Snip will freeze)
function snip_get_next_snip()
{
	//If there is a next snip then immediately return it and ignore everything else
	if (ae_snip_next_snip != undefined) { return ae_snip_next_snip;}
	
	//If there's not even an snip playing then return nothing
	var _current = ae_snip_current_snip;
	if (_current == undefined) { return undefined;}
	
	//The successor or precursor depending on whether or not a Snip is playing forwards or backwards
	var _follower = _current.snip_successor;
	var _follower_transition = _current.snip_successor_transition; //Whether or not to use the transition
	
	//If the current Snip has a "follower"
	if (_follower != undefined)
	{
		//Check to see if it should use a transition
		if (_follower_transition)
		{
			//Try to find transition
			var _transition = snip_find_transition(ae_snip_current_snip, _follower);
			//Return the transition if one was found
			if (_transition != undefined)
			{
				return _transition.snip_use;
			}
			else //If no transition was found then return the follower
			{
				return _follower;
			}
		} //If it should ignore transitions then return the follower
		else
		{
			return _follower;
		}
	}
	
	//If the Snip pingpongs or repeats then return it
	if (_current.snip_end_type != ae_snip_end.end_stop)  { return _current;}
	
	//If the Snip does not pingpong or repeat then it stops, so return undefined
	else { return undefined;}
}

///@func snip_index_to_frame(snip, index)
///@desc Returns the given sprite index as the given Snip's frame index
///@param {Snip} snip The snip to get the frame index of
///@param {int} index The sprite index number to convert into a Snip frame index
function snip_index_to_frame(_snip, _index)
{
	return _index - _snip.snip_frame_start;
}

///@func snip_frame_to_index(snip, frame)
///@desc Returns the given Snip frame as the sprite image index
///@param {Snip} snip The Snip that holds the given frame
///@param {int} frame The frame number within the given Snip to get the index of
function snip_frame_to_index(_snip, _frame)
{
	return _frame + _snip.snip_frame_start;
}

///@func snip_set_forward(snip)
///@desc Sets the Snip direction to forward
///@param {Snip} snip The Snip that should have its speed set to forward (does not change the speed, just whether or not it is negative)
function snip_set_forward(_snip)
{
	_snip.snip_direction = 1;
}

///@func snip_set_backward(snip)
///@desc Sets the Snip direction to backward
///@param {Snip} snip The Snip that should have its speed reversed (does not change the speed, just whether or not it is negative)
function snip_set_backward(_snip)
{
	_snip.snip_direction = -1;
}

///@func snip_reverse(_snip)
///@desc Sets the Snip direction to the opposite of what it currently is
///@param {Snip} snip The Snip to swap the direction of
function snip_reverse(_snip)
{
	_snip.snip_direction = -_snip.snip_direction;
}

///@func snip_get_direction(snip)
///@desc Gets the direction that a Snip is currently playing (-1 for backwards 1 for forwards)
///@param {Snip} snip The Snip to find the direction of
function snip_get_direction(_snip)
{
	return _snip.snip_direction;
}