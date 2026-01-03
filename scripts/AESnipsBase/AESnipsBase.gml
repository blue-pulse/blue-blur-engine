#region Global values
//Global variables
globalvar AE_SNIP_GLOBAL_IS_PAUSED
;

AE_SNIP_GLOBAL_IS_PAUSED = false;

//How the Snip should behave when it finishes playing
enum ae_snip_end {
	end_stop, //Freeze on the completed frame
	end_stop_head, //Jump back to the first frame and freeze
	end_stop_tail, //Jump to the last frame and freeze
	end_repeat, //Jump back to the first frame and play again (or the last frame if the Snip is being played backward)
	end_pingpong, //Reverse the Snip speed, transition to the next step when it hits the first or last frame
	end_pingpong_head, //Reverse the Snip speed, only transition to next Snip when it's back to the first frame
	end_pingpong_tail //Reverse the Snip speed, only transition to next Snip when it's back to the final frame
}
#endregion

#region Snip, Transition, and Loop creation

///@func Snip(sprite, speed, [start_frame], [end_frame])
///@desc Creates a new snip with the given sprite and default speed
///@param {sprite} sprite The sprite to use for the snip
///@param {real} speed The speed that the snip will play at (same scale as image_speed)
///@param {int} [start_frame] Optional argument to create an snip from a subsection of a sprite (default 0)
///@param {int} [end_frame] Optional argument to create an snip from a subsection of a sprite (default sprite_get_number(sprite)-1)
function Snip(_sprite, _speed, _start, _end) constructor
{
	snip_sprite = _sprite; //The sprite used for the snip
	snip_speed = _speed; //The speed that the snip should be played at
	incoming_transitions = ds_list_create(); //A list of transitions that lead to this snip
	outgoing_transitions = ds_list_create(); //A list of transitions that come from this snip
	
	//How the Snip should act when it finishes playing and there's not a Snip to play next
	snip_end_type = ae_snip_end.end_repeat;
	//The end_type will be overridden with snip_play_next(), or if the Snip has a successor/precursor
		
	//The successor will be overridden by the snip_play_next() function
	//Successors will also be ignored if the Snip is played as a transition
	snip_successor = undefined; //The Snip to play every time this Snip ends playing forward
	snip_successor_transition = false; //Whether or not to use Transitions when playing this Snip's successor
	
	snip_complete_script = undefined; //A script to execute when the snip finishes playing
	snip_complete_script_argument = undefined; //The argument to use in the script completion
	
	//Set the start frame of the snip to 0 if no value is given
	snip_frame_start = 0;
	if (_start != undefined) { snip_frame_start = _start } //Or set it to the given start value
	
	//Set the end value to sprite_get_number(_sprite)-1 if no value is given
	snip_frame_end = sprite_get_number(_sprite) - 1;
	if (_end != undefined) { snip_frame_end = _end; } //Or set it to the given end value
	
	//Get the total number of frames in the snip by subtracting the start from the end and adding 1
	snip_frame_count = (snip_frame_end - snip_frame_start) + 1;
	
	//Throw an error if the start and end don't match right
	if (snip_frame_count <= 0)
	{
		throw(	"Error creating snip for " + sprite_get_name(_sprite) +
				": End must be greater than start. Start:" + string(snip_frame_start) +
				" End:" + string(snip_frame_end));
	}
	
	//Array to hold per-frame items like speed and actions
	frame_speed = array_create(snip_frame_count, 1);
	frame_script = array_create(snip_frame_count, undefined);
	frame_script_argument = array_create(snip_frame_count, undefined);
	
	//A list to hold all the loops in the snip
	snip_loops = ds_list_create(); 
	
	//The default direction to play the Snip (1 for forward, -1 for backwards)
	snip_direction = 1;
	
	//A value to handle the Sprite speed and speed types
	snip_speed_scale = 1;
	if (_sprite != undefined)
	{
		if (sprite_get_speed_type(_sprite) == spritespeed_framespergameframe)
		{
			snip_speed_scale = sprite_get_speed(_sprite);
		}
		else
		{
			snip_speed_scale = sprite_get_speed(_sprite) / game_get_speed(gamespeed_fps);
		}
	}
	
	static toString = function()
	{
		return "Snip[" + sprite_get_name(snip_sprite) + "]";
	}
}

///@func snip_create_ext(sprite, speed, start frame, end frame, should repeat, successor)
///@desc Creates an snip with more paramaters
///@param {Sprite} sprite The sprite to use in the snip
///@param {real} speed The speed to play the snip at
///@param {int} start The frame within the sprite to start at (use -1 for default value of 0)
///@param {int} end The frame within the sprite to end at (use -1 for default value of sprite_get_number(sprite)-1)
///@param {ae_snip_end} endType How the Snip should behave when it reaches the end
///@param {Snip} successor A Snip to play after this snip finished playing forwards (use -1 or undefined for no successor)
function snip_create_ext(_sprite, _speed, _start_frame, _end_frame, _end_type, _successor)
{
	//Convert -1 start and end frames to their default values
	if (_start_frame == -1) { _start_frame = 0;}
	if (_end_frame == -1) { _end_frame = sprite_get_number(_sprite)-1;}
	
	var _snip = new Snip(_sprite, _speed, _start_frame, _end_frame); //Create a Snip with the available parameters
	_snip.snip_end_type = _end_type; //How to act when the snip reaches the end
	
	//Convert -1 to undefined
	if (_successor == -1) { _successor = undefined; }
	
	_snip.snip_successor = _successor; //The Snip to play after this Snip plays forward
	_snip.snip_successor_transition = (_successor != undefined); //Whether or not to try to play a transition between this Snip and its successor	
	
	return _snip;
}

///@func Transition(from, to, snip)
///@desc Creates a new transition between "from" and "to" using the given snip 
///@param {Snip} from The snip that the transition is coming from
///@param {Snip} to The snip the the transition is going to
///@param {Snip} snip The snip that should be played as the transition
function Transition(_from, _to, _snip) constructor
{
	//Set up the values for the Transition
	snip_from = _from; //The snip it is coming from
	snip_to = _to; //The snip it is going to
	snip_use = _snip; //The snip that will play as the transition
	
	//Add this transition to the incoming and outgoing lists of the snips
	ds_list_add(_to.incoming_transitions, self);
	ds_list_add(_from.outgoing_transitions, self);
	
	static toString = function()
	{
		return "Transition[" + string(snip_use) + "]";
	}
}

///@func Loop(snip, start, end, repeat)
///@desc Creates a loop in the snip that will play once and then repeat the given number of times
///@param {Snip} snip The snip that the loop will be a part of
///@param {int} start The frame that the loop starts at (inclusive)
///@param {int} end The frame that the loop will end at (inclusive)
///@param {int} repeat How many times to repeat after playing once (0 means the loop will play once and any number less than 0 will skip the loop entirely)
function Loop(_snip, _start, _end, _repeat) constructor
{
	loop_snip = _snip; //The snip that the loop belongs to
	loop_start = _start; //The start frame should always be a frame before the end
	
	loop_end = _end + 1; //The end frame should always be after the start
	//1 is added to make the end frame inclusive
	
	loop_repeat = _repeat; //Loops repeat once and then repeat this many times so they'll play (repeat + 1) times
	
	//Add the loop to the snip's list
	ds_list_add(_snip.snip_loops, self);
}
#endregion

#region Snip object events

///@func snip_create_event()
///@desc Sets up the variables for an individual object using the snip system
function snip_create_event()
{
	/* ! Changing these values directly from other parts of the code could cause big problems ! */
	/* ! Please use the given Arbiter functions unless you know what you're doing ! */
	//These are all instance variables for any object that is using the Snip system
	
	/*@private*/	ae_snip_current_snip = undefined;	//The snip that is currently playing
	/*@private*/	ae_snip_current_loop = undefined;	//The loop that the Snip is currently playing
	/*@private*/	ae_snip_current_frame = -1;			//The frame that the Snip is currently on
	/*@private*/	ae_snip_next_snip = undefined;		//The snip that is set to play when the current snip finishes
	/*@private*/	ae_snip_is_paused = false;			//Whether or not the object playing the snip is paused
	/*@private*/	ae_snip_is_frozen = false;			//Whether or not the snip should has been frozen on the last frame
	/*@private*/	ae_snip_should_transition = false;	//Whether or not the snip should try to transition to the next snip
	/*@private*/	ae_snip_current_target = undefined;	//If a transition is playing then this will hold the snip that the snip is supposed to transitioning to
	/*@private*/	ae_snip_loop_performances = [];		//How many times this loop has been repeated as the current snip is playing
	/*@private*/	ae_snip_changed = false;			//Whether or not the Snip has changed since the last step
	/*@private*/	ae_snip_direction = 1;				//The direction (forwards:1 or backwards:-1) that the current Snip is being played at
}

///@func snip_step_event()
///@desc Controls an object's snip durign the Step Event
function snip_step_event()
{
	//Quit if there is no snip
	if (self.ae_snip_current_snip == undefined) { return; }
	//Continue with the script if there is an snip playing
	
	//Should be placed in the Step Event for each object that uses the snip system
	var _snip = self.ae_snip_current_snip; //Get the snip that is currently playing
	var _index = self.image_index; //Get the current image index
	var _start = self.ae_snip_current_snip.snip_frame_start;
	var _end = self.ae_snip_current_snip.snip_frame_end;
	//Whether or not the Snip is being played forward
	var _snip_forward = (ae_snip_direction * _snip.snip_direction*_snip.snip_speed) > 0;

	var _frame_speed = _snip.frame_speed[(_index - _start)] //The speed for the current snip's current frame
	
	//Adjust the speed of the sprite depending on the following values
	//Frame Speed - Snip Speed - Snip Direction - Individual snip paused? - Individual Snip stopped? - All snips paused?
	image_speed = _frame_speed //The speed for the current snip's current frame
				* _snip.snip_speed //The speed for the whole current snip
				* _snip.snip_direction //Whether the Snip wants to be played forwards or backwards
				* ae_snip_direction  //Whether the Snip is being played forwards or backwards by the object
				* !ae_snip_is_paused //If the snip is paused then this is 0, if not then it's 1
				* !ae_snip_is_frozen //If the snip is frozen at the end of an snip
				* !AE_SNIP_GLOBAL_IS_PAUSED; //If the snip system as a whole is paused
				
	//Find out what frame the Snip will be on next frame
	var _next_frame = _index + (image_speed * _snip.snip_speed_scale);
	
	//Check to see if the Snip's next frame will go past the end or the start
	if ((_next_frame >= _end+1-math_get_epsilon() and _snip_forward)
	or (_next_frame <= _start and !_snip_forward))
	{		
		//Call the Snip End Event Script to simulate the end of a sprite animating
		snip_animation_end_event();
		
		//Reset the image speed so the current speed doesn't impact the next snip
		image_speed = 0;
		
		//Break out of this step script and restart next frame
		return;
	}
	
	//Before anything happens see if the snip is on a new frame
	if (floor(ae_snip_current_frame) != floor(self.image_index - _start)
	or ae_snip_changed)
	{
		//Make sure there is an Snip playing
		if (ae_snip_current_snip != undefined)
		{
			//Get the script for the current frame (undefined if there is no script)
			var _script = ae_snip_current_snip.frame_script[self.image_index - _start];
			//Get the argument set for the script
			var _arg = ae_snip_current_snip.frame_script_argument[self.image_index - _start];
		
			//Check to see if there is a script to execute
			if (_script != undefined)
			{
				//If the script is a method then execute it like a method
				if (is_method(_script))
				{
					_script(_arg);
				}
				else //If not, then execute it like a script
				{
					if (_arg != undefined)
					{
						script_execute(_script, _arg);
					}
					else
					{
						script_execute(_script);
					}
				}
			}
		}
		//Reset the Snip change variable
		ae_snip_changed = false;
	}
	
	//This has to happen after checking whether or not a Snip is on a new frame
	ae_snip_current_frame = _index - _start; //Set the current frame to the image index

	//Only do this Snip logic if both the snip and the snip system are not paused
	if (!ae_snip_is_paused and !AE_SNIP_GLOBAL_IS_PAUSED and !ae_snip_is_frozen)
	{
		//If the snip has more than 0 loops
		if (ds_list_size(_snip.snip_loops) > 0)
		{
			//If the object isn't currently playing a loop
			if (ae_snip_current_loop == undefined)
			{
				//Loop through all the Snip's Loops
				var _i = 0;
				repeat(ds_list_size(_snip.snip_loops))
				{
					//Get the current loop
					var _current_loop = _snip.snip_loops[|_i];
					//{bool} Find out if the current index is within the start and end of the loop
					var _is_within_loop = (_index - _start >= _current_loop.loop_start and _index - _start < _current_loop.loop_end);
					//{bool} Find out whether or not the loop has already been performed the proper number of times
					var _loop_done_performing = (ae_snip_loop_performances[_i] >= _current_loop.loop_repeat);
					//{bool} Find out if the system should just completely skip the loop
					var _loop_should_skip = (_current_loop.loop_repeat < 0 and ae_snip_loop_performances[_i] <=0);
					
					//No use the three bool variables to handle looping the snip properly
					if (_is_within_loop and (!_loop_done_performing or _loop_should_skip))
					{
						//If the loop should be skipped then skip it
						if (_loop_should_skip)
						{
							//Tell the loop that is has been performed
							ae_snip_loop_performances[_i] += 1;
							
							//If the Snip is being played forward
							if (_snip_forward)
							{
								//Jump to the end of the loop and skip everything inside the loop
								image_index = _current_loop.loop_end - _start;
							}
							else //If the Snip is being played backward
							{
								//Jump to the end of the loop and skip everything inside the loop
								image_index = _current_loop.loop_start - _start - math_get_epsilon();
							}
							break; //Break out of the repeat()
						}
						else //The loop should not skip
						{
							//Set the object's currently playing loop
							ae_snip_current_loop = _current_loop;
							ae_snip_current_loop_index = _i;
							break; //Break out of the repeat()
						}
					}
					//Don't forget to increment the counter!
					_i += 1;
				}
			}
			else //If the Snip is currently in the middle of a loop
			{
				//Get the loop that is currently being played
				var _currently_playing_loop = ae_snip_current_loop;
				
				//If the Snip has played past the end of the Loop
				var _snip_past_end = (_index - _start >= _currently_playing_loop.loop_end);
				//If the Snip has played past the start of the Loop (assuming it is being played backwards)
				var _snip_past_start = (_index - _start < _currently_playing_loop.loop_start);
				
				//If the Snip has reached the end of the loop (either forward or backward)
				if ((_snip_past_end and _snip_forward)
				or (_snip_past_start and !_snip_forward))
				{
					//Tell the loop that it has been performed by incrementing the variable
					ae_snip_loop_performances[ae_snip_current_loop_index] += 1;
					
					//If the Snip is being played forward
					if (_snip_forward)
					{
						//Set the current image index to the start of the Loop
						image_index = _currently_playing_loop.loop_start + _start;
					}
					else
					{
						//Set the current image index to the end of the Loop
						image_index = _currently_playing_loop.loop_end + _start - math_get_epsilon();
					}
					
					//If the loop has been repeated the proper number of times
					//Tell the object that it is no longer inside that loop
					if (ae_snip_loop_performances[ae_snip_current_loop_index] >= _currently_playing_loop.loop_repeat)
					{
						//Reset the current loop variable
						ae_snip_current_loop = undefined;
						ae_snip_current_loop_index = -1;
					}
				}
			}
		} // ^^ If the snip has more than 0 loops ^^
	} // ^^^ If the snip is actually playing ^^^ 
}

///@func snip_animation_end_event()
///@desc Controls an object's Snip when it finishes playing
/// @private
function snip_animation_end_event()
{	
	//If there's not a Snip playing then just return false and skip the rest of the function
	if (ae_snip_current_snip == undefined)
	{
		return;
	}
	
	//If the Snip is currently in the middle of a loop
	if (ae_snip_current_loop != undefined)
	{
		//Whether or not the Snip is being played forward
		var _snip_forward = ae_snip_current_snip.snip_direction*ae_snip_direction >= 0;
		//The starting frame of the Snip
		var _start = ae_snip_current_snip.snip_frame_start;
		
		//Tell the loop that it has been performed by incrementing the variable
		ae_snip_loop_performances[ae_snip_current_loop_index] += 1;
					
		//If the Snip is being played forward
		if (_snip_forward)
		{
			//Set the current image index to the start of the Loop
			image_index = ae_snip_current_loop.loop_start + _start;
		}
		else
		{
			//Set the current image index to the end of the Loop
			image_index = ae_snip_current_loop.loop_end + _start - math_get_epsilon();
		}
					
		//If the loop has been repeated the proper number of times
		//Tell the object that it is no longer inside that loop
		if (ae_snip_loop_performances[ae_snip_current_loop_index] >= ae_snip_current_loop.loop_repeat)
		{
			//Reset the current loop variable
			ae_snip_current_loop = undefined;
			ae_snip_current_loop_index = -1;
		}
		
		//Return to skip the rest of the function
		return;
	}
	
	//We know a Snip is playing
	//If the Snip's end type is a pingpong_first, we reverse the animation speed and skip the rest
	if (ae_snip_current_snip.snip_end_type = ae_snip_end.end_pingpong_head)
	{
		//Check to see if the Snip is playing forwards
		if (snip_get_speed(ae_snip_current_snip) * snip_get_direction(ae_snip_current_snip) * ae_snip_direction > 0)
		{
			//Set the image_index to the last frame possible
			image_index = ae_snip_current_snip.snip_frame_end + (1 - math_get_epsilon());
			//Tell the object to start playing the Snip in the opposite direction
			ae_snip_direction = -ae_snip_direction;
			//Reset the loops
			snip_reset_loops(ae_snip_current_snip);
			//Return so the Snip never actually "completes"
			return;
		}
	}
	//If the Snip's end type is a pingpong_last, we reverse the animation speed and skip the rest
	if (ae_snip_current_snip.snip_end_type = ae_snip_end.end_pingpong_tail)
	{
		//Check to see if the Snip is playing backwards
		if (snip_get_speed(ae_snip_current_snip) * snip_get_direction(ae_snip_current_snip) * ae_snip_direction < 0)
		{
			//Make sure to jump to the start
			image_index = ae_snip_current_snip.snip_frame_start; //Reset the image_index to the start 
			//Tell the object to start playing the Snip in the opposite direction
			ae_snip_direction = -ae_snip_direction;
			//Reset the loops
			snip_reset_loops(ae_snip_current_snip);
			//Return so the Snip never actually "completes"
			return;
		}
	}
	
	//If there is a script/method to execute then allow execute it
	if (ae_snip_current_snip.snip_complete_script != undefined)
	{
		//If the script is a method
		if (is_method(ae_snip_current_snip.snip_complete_script))
		{
			//Execute it as a method with the argument
			ae_snip_current_snip.snip_complete_script(ae_snip_current_snip.snip_complete_script_argument);
		}
		else //If it's not a method
		{
			//Execute it as a script with the argument
			script_execute(ae_snip_current_snip.snip_complete_script, ae_snip_current_snip.snip_complete_script_argument);
		}
	}
	
	//If there's a next snip that should be played and it's not the same snip
	if (ae_snip_next_snip != ae_snip_current_snip and ae_snip_next_snip != undefined)
	{
		//Play the snip and use the transition if desired
		snip_play(ae_snip_next_snip, ae_snip_should_transition)
	}
	else
	{
		//If there isn't a next snip to play then look for a successor to the current snip
		if (ae_snip_next_snip == undefined)
		{
			//Get the follow-up Snip and should_transition value
			var _follower = ae_snip_current_snip.snip_successor;
			var _follower_transition = ae_snip_current_snip.snip_successor_transition;
			
			//If there is a follow-up Snip
			if (_follower != undefined)
			{
				//Then play it immediately with the snip's successor transition variable
				snip_play(_follower, _follower_transition);
			}
			else
			{
				switch (ae_snip_current_snip.snip_end_type)
				{
					case ae_snip_end.end_repeat:
						//If the Snip is being played forwards
						if (ae_snip_current_snip.snip_direction*ae_snip_direction >= 0)
						{
							//Just loop the Snip by going back to the start
							image_index = ae_snip_current_snip.snip_frame_start; //Reset the image_index to the start 
						}
						else //If the Snip is being played backwards
						{
							//Just loop the Snip by going to the end of the final frame (as close to snip_frame_end+1 as possible)
							image_index = ae_snip_current_snip.snip_frame_end + (1 - math_get_epsilon());
						}
						ae_snip_current_frame = image_index; //Set the current frame to the image index
						ae_snip_current_loop = undefined; //Reset the loop value
						ae_snip_current_loop_index = -1; //Reset the loop index
						ae_snip_changed = true; //Tell the object that the snip has changed because it has looped back					
						snip_reset_loops(ae_snip_current_snip); //Reset the loops
					break;
					case ae_snip_end.end_stop:
						image_speed = 0; //Freeze the image_speed so it stays on that index
						ae_snip_current_frame = image_index; //Set the current frame to the image index
						ae_snip_is_frozen = true; //Freeze the Snip so it won't keep repeating
					break;
					case ae_snip_end.end_stop_tail:
						//Set the Snip to the very last frame
						image_index = ae_snip_current_snip.snip_frame_end; //Make sure the image is on the last frame 
						image_speed = 0; //Freeze the image_speed so it stays on that index
						ae_snip_current_frame = image_index; //Set the current frame to the image index
						ae_snip_is_frozen = true; //Freeze the Snip so it won't keep repeating
					break;					
					case ae_snip_end.end_stop_head:
						//Jump back to the first frame and freeze
						image_index = ae_snip_current_snip.snip_frame_start; //Make sure the image is on the first frame 
						image_speed = 0; //Freeze the image_speed so it stays on that index
						ae_snip_current_frame = image_index; //Set the current frame to the image index
						ae_snip_is_frozen = true; //Freeze the Snip so it won't keep repeating
					break;
					//If the Snip should pingpong
					case ae_snip_end.end_pingpong:
					case ae_snip_end.end_pingpong_head:
					case ae_snip_end.end_pingpong_tail:
						var _is_forward = (snip_get_speed(ae_snip_current_snip) * snip_get_direction(ae_snip_current_snip) * ae_snip_direction) > 0;
						//If the Snip is being played backwards in the pingpong
						if (!_is_forward)
						{
							//Make sure to jump to the start
							image_index = ae_snip_current_snip.snip_frame_start; //Reset the image_index to the start 
							//Reverse the direction that the object is playing the Snip at
							ae_snip_direction = -ae_snip_direction;
						}
						else //If the Snip is being played forwards
						{
							//Set the image_index to the last frame possible
							image_index = ae_snip_current_snip.snip_frame_end + (1 - math_get_epsilon());
							//Reverse the direction that the object is playing the Snip at
							ae_snip_direction = -ae_snip_direction;
						}
						//Clear the image speed
						image_speed = 0;
						//Reset the Snip's current frame
						ae_snip_current_frame = image_index; //Set the current frame to the image index
						//Reset the loops
						snip_reset_loops(ae_snip_current_snip);
					break;
				}
			}
		}
		else
		{
			//If the Snip should just play itself again
			snip_play(ae_snip_current_snip, false);
		}
	}	
}
#endregion Snip object events

#region Snip controls

///@function snip_play(snip, should_transition)
///@desc Immediately plays the given snip with or without transition
///@param {Snip} snip The snip to play
///@param {bool} should_transition Whether or not the system should try to find a transition between the current snip and the snip to play
function snip_play(_snip, _should_transition)
{	
	//Unfreeze the Snip any time a new Snip is played
	ae_snip_is_frozen = false;
	
	//Reset the direction that the object should play the Snip at
	ae_snip_direction = 1;
	
	//If the given Snip is different than the current Snip, set the Snip as changed
	if (_snip != ae_snip_current_snip)
	{
		ae_snip_changed = true;
	}
	
	//By default use the given snip as the Snip to play
	var _play_snip = _snip;
	//By default there should be no next Snip
	var _next_snip = undefined;
	
	//If the system should search for a transition and there is an snip currently playing
	if (_should_transition and ae_snip_current_snip != undefined)
	{
		//When looking for the transition use the current Snip as the "from"
		var _from = ae_snip_current_snip;
		
		//If the Snip is currently transitioning to another Snip then use the target as the "from"
		if (ae_snip_current_target != undefined)
		{
			_from = ae_snip_current_target;
		}
		
		//Reset the target variable here
		ae_snip_current_target = undefined;
		
		//Try to find a transition snip to play
		var _transition = snip_find_transition(_from, _snip);
		
		//If a transition was found then do not use the given snip, use the transition snip
		if (_transition != undefined)
		{
			//Set the play snip to the transition's use snip
			_play_snip = _transition.snip_use;
			//Tell the system to play the given snip after the transition snip is done
			_next_snip = _snip;
			//Save the target of the transition into the target variable
			ae_snip_current_target = _snip;
		}
	}
	else //If the system should not search for a transition then clear the target
	{
		ae_snip_current_target = undefined;
	}
	
	self.ae_snip_current_snip = _play_snip; //Set the current snip
	self.ae_snip_next_snip = _next_snip; //Reset the next snip
	self.ae_snip_current_loop = undefined; //Reset the current loop
	sprite_index = _play_snip.snip_sprite; //Set the proper sprite index
	
	//If the next Snip will be played forwards
	if (_play_snip.snip_direction >= 0)
	{
		//Set the index to the start
		image_index = _play_snip.snip_frame_start;
		//Stop the animation for just a moment
		image_speed = 0;
	}
	else //If the next Snip will be played backwards
	{
		//Set the index to the end 
		image_index = ae_snip_current_snip.snip_frame_end + (1 - math_get_epsilon());
		//Stop the animation for just a moment
		image_speed = 0;
	}
	
	self.ae_snip_current_frame = image_index;
	
	//Reset all the loop counters in the object
	if (self.ae_snip_current_snip != undefined)
	{
		snip_reset_loops(self.ae_snip_current_snip);
	}
}

///@func snip_start(snip)
///@desc Starts the snip system with the given snip
///@param {Snip} snip The snip to start with
function snip_start(_snip)
{
	snip_play(_snip, false);
}

///@function snip_play_next(snip, should_transition)
///@desc Sets an snip to play as soon as the current snip is done playing
///@param {Snip} snip The snip to play
///@param {bool} should_transition Whether or not the system should try to find a transition between the current snip and the snip to play
function snip_play_next(_snip, _should_transition)
{
	//If there isn't an Snip playing right now
	if (ae_snip_current_snip == undefined or ae_snip_is_frozen)
	{
		//Just play the snip now
		snip_play(_snip, _should_transition);
	}
	else
	{
		//Set the snip to play on the Snip End
		ae_snip_next_snip = _snip;
		ae_snip_should_transition = _should_transition;
	}
}

///@func snip_cancel_play_next()
///@desc This will cancel the Snip that the object has depthsd to play next
function snip_cancel_play_next()
{
	//If the Snip is transitioning then the current target will have a Snip
	//So this will play the Snip that is being transitioned to
	
	//But if the Snip is not transitioning then the current target will be undefined
	//So this will clear the next Snip value
	ae_snip_next_snip = ae_snip_current_target;
	ae_snip_should_transition = false;
}

///@func snip_reset_loops(snip)
///@desc Resets the performance count in all the loops in the given snip
///@param {Snip} snip The snip that the loops are a part of
function snip_reset_loops(_snip)
{	
	//Clear out the performance array
	ae_snip_loop_performances = [];
	
	//Loop through all the loops in the given snip
	var _i =0;
	repeat(ds_list_size(_snip.snip_loops))
	{
		//Tell the loop that it has been performed 0 times
		ae_snip_loop_performances[_i] = 0;
		_i += 1;
	}
}

///@func snip_find_transition(from, to)
///@desc Returns a transition snip between the from snip and the to snip (or undefined if none exists)
///@param {Snip} from The snip that the transition comes from
///@param {Snip} to The snip that the transition comes from
function snip_find_transition(_from, _to)
{
	//The list to loop through to try to find the snip
	var _use_list = _from.outgoing_transitions;
	//Get the size of the from's outgoing list
	var _out_size = ds_list_size(_from.outgoing_transitions);
	//Get the size of the to's incoming list
	var _in_size = ds_list_size(_to.incoming_transitions);
	//If the from list is smaller than the in list
	if (_out_size < _in_size)
	{
		//Search through the to's incoming transitions
		_use_list = _to.incoming_transitions;
	}
	
	//Loop through the from list or the to list
	var _i = 0;
	repeat(ds_list_size(_use_list))
	{
		//Get the current snip in the list
		var _current_transition = _use_list[|_i];
		if (_current_transition.snip_from == _from and _current_transition.snip_to == _to)
		{
			//Return the transition's use snip if it matches the from and the to
			return _current_transition;
		}
		_i += 1;
	}
	//If no transition has been found then return undefined
	return undefined;
}

///@func snip_clone(snip)
///@desc Creates a copy of the given snip and creates new transitions and loops to exactly match the snip
///@param {Snip} snip The snip to clone
function snip_clone(_snip)
{
	//Create a new Snip with the same properties
	var _new_snip = snip_create_ext(_snip.snip_sprite,
												_snip.snip_speed,
												_snip.snip_frame_start,
												_snip.snip_frame_end,
												_snip.snip_end_type,
												_snip.snip_successor);
	//Set other properties of the snip
	_new_snip.snip_successor_transition =	_snip.snip_successor_transition;
	_new_snip.snip_complete_script = _snip.snip_complete_script;
	_new_snip.snip_complete_script_argument = _snip.snip_complete_script_argument;
	_new_snip.snip_direction = _snip.snip_direction;
	
	//Loop through all the snip frames and copy the speeds
	var _i = 0;
	repeat(_snip.snip_frame_count)
	{
		snip_set_frame_speed(_new_snip, _i, _snip.frame_speed[_i]);
		snip_set_frame_script(_new_snip, _i, _snip.frame_script[_i], _snip.frame_script_argument[_i]);
		_i += 1;
	}
	
	//Iterate through all the loops and create new loops for the new snip
	_i = 0;
	repeat(ds_list_size(_snip.snip_loops))
	{
		var _loop = _snip.snip_loops[|_i];
		var _new_loop = new Loop(_new_snip, _loop.loop_start, _loop.loop_end, _loop.loop_repeat);
		_i += 1;
	}
	
	//Iterate through all the incoming transitions and add them to the new snip
	_i = 0;
	repeat(ds_list_size(_snip.incoming_transitions))
	{
		var _transition = _snip.incoming_transitions[|_i];
		var _new_transition = new Transition(_transition.snip_from, _new_snip, _transition.snip_use);
		_i += 1;
	}
	
	//Iterate through all the outgoing transitions and add them to the new snip
	_i = 0;
	repeat(ds_list_size(_snip.outgoing_transitions))
	{
		var _transition = _snip.outgoing_transitions[|_i];
		var _new_transition = new Transition(_new_snip, _transition.snip_to,_transition.snip_use);
		_i += 1;
	}
	
	return _new_snip;
}

///@func snip_clone_transitions(source, destination)
///@desc Clones all the Transitions associated with the source and applies them to the destination as well (clears all previous Transitions in the destination)
///@param {Snip} source The Snip with the Transitions 
///@param {Snip} destination The Snip that you want to clone the Transitions to
function snip_clone_transitions(_source, _destination)
{
	if (_source == undefined)
	{
		throw "snip_clone_transitions() Source undefined";
		return;
	}
	if (_destination == undefined)
	{
		throw "snip_clone_transitions() destination undefined";
		return;
	}
	
	//Iterate through all the incoming transitions and add them to the destination
	var _i = 0;
	repeat(ds_list_size(_source.incoming_transitions))
	{
		var _transition = _source.incoming_transitions[|_i];
		var _new_transition = new Transition(_transition.snip_from, _destination, _transition.snip_use);
		_i += 1;
	}
	
	//Iterate through all the outgoing transitions and add them to the new snip
	_i = 0;
	repeat(ds_list_size(_source.outgoing_transitions))
	{
		var _transition = _source.outgoing_transitions[|_i];
		var _new_transition = new Transition(_destination, _transition.snip_to,_transition.snip_use);
		_i += 1;
	}
}

///@func snip_clone_loops(source, destination)
///@desc Clones all the Loops found in the source Snip and applies them to the destination Snip (unless the Loop is outside the bounds of the destination)
///@param {Snip} source The Snip to copy the Loops from
///@param {Snip} destination The Snip to copy the Loops to
function snip_clone_loops(_source, _destination)
{
	//Iterate through all the loops and create new Loops for the destination
	var _i = 0;
	repeat(ds_list_size(_source.snip_loops))
	{
		var _loop = _source.snip_loops[|_i];
		if (_loop.loop_start > _source.snip_frame_start
		and _loop.loop_end < _source.snip_frame_end)
		{
			var _new_loop = new Loop(_new_snip, _loop.loop_start, _loop.loop_end, _loop.loop_repeat);
		}
		_i += 1;
	}
}	

///@func snip_pause()
///@desc Pauses the Snip that the object is currently playing
function snip_pause()
{
	ae_snip_is_paused = true;
}

///@func snip_resume()
///@desc Un-pauses the Snip that the object is currently playing
function snip_resume()
{
	ae_snip_is_paused = false
}

///@func snip_stop_tail()
///@desc Stops the Snip that the object is currently playing and jumps to the last frame (as if the end_type is end_stop)
function snip_stop_tail()
{
	//Set the Snip to the very last frame
	image_index = ae_snip_current_snip.snip_frame_end; //Make sure the image is on the last frame 
	image_speed = 0; //Freeze the image_speed so it stays on that index
	ae_snip_current_frame = image_index; //Set the current frame to the image index
	ae_snip_is_frozen = true; //Freeze the Snip so it won't keep repeating
}

///@func snip_stop_head()
///@desc Stops the Snip that the object is currently playing and reloads it to the first frame (as if the end_type is end_stop_beginning)
function snip_stop_head()
{
	//Jump back to the first frame and freeze
	image_index = ae_snip_current_snip.snip_frame_start; //Make sure the image is on the first frame 
	image_speed = 0; //Freeze the image_speed so it stays on that index
	ae_snip_current_frame = image_index; //Set the current frame to the image index
	ae_snip_is_frozen = true; //Freeze the Snip so it won't keep repeating	
}

///@func snip_stop()
///@desc Stops the Snip that the object is currently playing on the exact frame
function snip_stop()
{
	image_speed = 0; //Freeze the image_speed so it stays on that index
	ae_snip_current_frame = image_index; //Set the current frame to the image index
	ae_snip_is_frozen = true; //Freeze the Snip so it stops completely
}

///@func snip_play_request(snip, transition)
///@desc Only plays the given Snip if it is not already playing
///@param {Snip} snip The Snip you would like to play
///@param {bool} should_transition Whether or not to Transition when playing the Snip
function snip_play_request(_snip, _should_transition)
{
	//Only play the Snip if it is not currently playing
	if (!snip_is_playing(_snip, true))
	{
		snip_play(_snip, _should_transition);
	}
}

///@func snip_global_pause()
///@desc Pauses the entire snip system
function snip_global_pause()
{
	AE_SNIP_GLOBAL_IS_PAUSED = true;
}

///@func snip_global_resume()
///@desc Resumes the entire snip system (but does not resume snips that have been individually paused)
function snip_global_resume()
{
	AE_SNIP_GLOBAL_IS_PAUSED = false;
}

///@func snip_transition_clone_reverse(transition)
///@desc Clones a Transition and reverses it by swapping the "to" and "from" and creating a reversed copy of the "use" Snip
///@param {Transition} transition The Transition to build a reverse clone of
function snip_transition_clone_reverse(_transition)
{
	//Clone the Snip that the given Transition uses
	var _new_snip = snip_clone(snip_get_transition_snip(_transition));
	//Reverse the Snip that the given Transition uses
	snip_reverse(_new_snip);
	//Create a new Transition with the "to" and "from" swapped
	var _new_transition = new Transition(snip_get_transition_to(_transition), snip_get_transition_from(_transition), _new_snip);
	return _new_transition;
}


///@function snip_destroy_snip(snip)
///@desc Destroys the given Snip along will all associated transitions and loops
///@param {Snip} snip The snip to destroy
function snip_destroy_snip(_snip)
{
	//Make sure the object isn't playing the snip anymore if it is
	if (ae_snip_current_snip == _snip)
	{
		ae_snip_current_snip = undefined;
	}
	if (ae_snip_current_target == _snip)
	{
		ae_snip_current_target = undefined;
	}
	if (ae_snip_next_snip == _snip)
	{
		ae_snip_next_snip = undefined;
	}
	
	//First destroy all incoming transitions
	var _i = 0;
	repeat(ds_list_size(_snip.incoming_transitions))
	{
		delete _snip.incoming_transitions[|_i];
		_i+= 1;
	}
	
	//Now destroy all incoming transitions
	_i = 0;
	repeat(ds_list_size(_snip.outgoing_transitions))
	{
		delete _snip.outgoing_transitions[|_i];
		_i+= 1;
	}
	
	//Now destroy all loops
	_i = 0;
	repeat(ds_list_size(_snip.snip_loops))
	{
		delete _snip.snip_loops[|_i];
		_i+= 1;
	}
	
	//Now destroy all lists
	ds_list_destroy(_snip.incoming_transitions);
	ds_list_destroy(_snip.outgoing_transitions);
	ds_list_destroy(_snip.snip_loops);
	//Just to be safe destroy all arrays too
	_snip.frame_speed = -1;
	_snip.frame_script = -1;
	_snip.frame_script_argument = -1;
	

	//Now delete the snip :(
	delete _snip;
}

///@func snip_destroy_transition(transition)
///@desc Destroys the transition and removes it from the incoming and outgoing lists of the appropriate Snips
///@param {Transition} transition The Transition to destroy
function snip_destroy_transition(_transition)
{
	//Get the two snips
	var _from = _transition.snip_from;
	var _to = _transition.snip_to;
	
	//Delete the snip from the incoming and outgoing lists
	ds_list_delete(_from.outgoing_transitions, ds_list_find_index(_from.outgoing_transitions, _transition));
	ds_list_delete(_to.incoming_transitions, ds_list_find_index(_to.incoming_transitions, _transition));
	
	//Delete the transition
	delete _transition;
}

///@func snip_destroy_loop(loop)
///@desc Destroy the given lool
///@param {Loop} loop The Loop to destoy
function snip_destroy_loop(_loop)
{
	//Get the snip that the loop is attached to
	var _snip = _loop.loop_snip;
	//Delete the loop from the list
	ds_list_delete(_snip.snip_loops, ds_list_find_index(_snip.snip_loops, _loop));
	//Delete the loop
	delete _loop;
}
#endregion Snip Controls

#region Snip debug
///@func snip_draw_debug(x,y)
///@desc Draws a visual representation of the Snip that an Object is currently playing
///@param {real} x The x position to draw the debug panel
///@param {real} y The y position to draw the debug panel
function snip_draw_debug(_x,_y)
{	
	//Get the draw values so that it can be reset at the end of the function
	var _old_color = draw_get_color();
	var _old_alpha = draw_get_alpha();
	
	//The first step is to quit with a red box if there is no Snip associated with the object
	if (ae_snip_current_snip == undefined)
	{
		draw_set_color(c_red);
			draw_rectangle(_x,_y, _x+16, _y+16, false);
		draw_set_color(_old_color);
		return;
	}
	
	//The next step is to get all the relevant information from the currently playing Snip
	var _sprite = ae_snip_current_snip.snip_sprite;
	var _width = sprite_get_width(_sprite);
	var _height = sprite_get_height(_sprite);
	var _count = sprite_get_number(_sprite);
	var _start = ae_snip_current_snip.snip_frame_start;
	var _end = ae_snip_current_snip.snip_frame_end;
	var _index = floor(image_index);
	
	//Now set up values to change the way it looks
	var _back_color = c_white;
	var _progress_bar_color = c_lime;
	var _separation = 2;
	var _transparent_amount = .4;
	var _current_frame_offset = floor(_height * .25);
	var _loop_line_size = floor(_width * .1);
	var _loop_current_color = c_lime;
	var _loop_color = c_aqua;
	var _loop_zero_color = c_yellow;
	var _loop_none_color = c_red;
	var _loop_alpha = .7;
	var _no_loop_alpha = .25;
	var _frame_script_color = c_orange;
	
	var _sprite_x_axis = sprite_get_xoffset(_sprite);
	var _sprite_y_axis = sprite_get_yoffset(_sprite);
	
	//Draw each frame of the sprite
	var _i = 0;
	repeat(_count)
	{
		//Get the x and y values for the current sprite frame
		var _x1 = _x + (_i * _width) + (_separation * _i);
		var _x2 = _x1 + _width;
		var _y1 = _y;
		var _y2 = _y + _height;
		
		//Draw a background for the sprite
		//If it's a part of the Snip then it should have full opacity
		//If it's not then reduce the alpha
		if (_i >= _start and _i <= _end)
		{
			//The frame is part of the Snip so set the alpha to 1
			draw_set_alpha(1);
		}
		else
		{
			//Set the alpha to the transparent value
			draw_set_alpha(_transparent_amount);
		}
		
		//Make the frame stick out if it's the current image_index
		if (_i == _index)
		{
			_y2 = _y + _height + _current_frame_offset;
		}
		
		//Now draw everything
		draw_set_color(_back_color);
		
		//Draw the background for the frame
		draw_rectangle(_x1, _y1, _x2, _y2, false);
		
		//Draw each sprite frame
		draw_sprite(_sprite, _i, _x1 + _sprite_x_axis, _y1 + _sprite_y_axis);
		
		//If the frame has a script add a small dot below it
		if (_i - ae_snip_current_snip.snip_frame_start < array_length(ae_snip_current_snip.frame_script)
		and _i - ae_snip_current_snip.snip_frame_start >= 0)
		{
			if (ae_snip_current_snip.frame_script[_i - ae_snip_current_snip.snip_frame_start] != undefined)
			{
				draw_set_color(_frame_script_color);
				draw_ellipse(_x1 + (_width /2), _y1 + _height, _x1 + (_width/2) + 5, _y1 + _height + 5, false);
			}
		}
		
		_i += 1;
	}
	
	draw_set_alpha(1);
	
	//Now draw some more things
	//A progress bar to show how much time has been spent on a single frame
	var _px1 = _x + (_index * _width)  + (_separation * _index);
	var _px2 = _px1 + (_width * (image_index - _index));
	var _py1 = _y + _height + 1;
	var _py2 = _py1 + _current_frame_offset - 1;
	draw_set_color(_progress_bar_color);
	draw_rectangle(_px1, _py1, _px2, _py2, false);
	
	//Now draw the Loops in the Snip
	//First, draw the base loops
	_i = 0;
	repeat(ds_list_size(ae_snip_current_snip.snip_loops))
	{
		//Get the loop
		var _loop = ae_snip_current_snip.snip_loops[|_i];
		
		//If the loop should repeat
		if(_loop.loop_repeat > 0)
		{
			draw_set_color(_loop_color);
			
			if (_loop == ae_snip_current_loop)
			{
				draw_set_color(_loop_current_color);
			}
			
			draw_set_alpha(_loop_alpha);
		}
		else
		{
			draw_set_alpha(_no_loop_alpha);
			//If the loop should skip
			if (_loop.loop_repeat < 0)
			{
				draw_set_color(_loop_none_color);
			}
			else //If the loop should play without repeating
			{
				draw_set_color(_loop_zero_color);
			}
			
		}
		
		//Get the values for the start vertical line
		var _sx1 = _x + ((_loop.loop_start + _start) * _width) + (_separation * (_loop.loop_start + _start));
		var _sx2 = _sx1 + _loop_line_size;
			
		//Get the values for the end vertical line
		var _ex1 = _x + ((_loop.loop_end + _start) * _width) - (_loop_line_size*2) + ((_loop.loop_end + 1 + _start) * _separation) - 1;
		var _ex2 = _ex1 + _loop_line_size;
			
		//Get the vertical values
		var _ly1 = _y + _height + 1;
		var _ly2 = _ly1 + ((_i+1) * _loop_line_size) + (_i * _separation) + _current_frame_offset;
			
		//Draw the vertical lines on the start and end frames
		draw_rectangle(_sx1, _ly1, _sx2, _ly2 - 1, false);
		draw_rectangle(_ex1, _ly1, _ex2, _ly2 - 1, false);
		//Draw the horizontal line
		draw_rectangle(_sx1, _ly2, _ex2, _ly2 + _loop_line_size - 1, false);
		
		_i +=1;
	}
	
	//Reset back to the old values
	draw_set_color(_old_color);
	draw_set_alpha(_old_alpha);
}

#endregion