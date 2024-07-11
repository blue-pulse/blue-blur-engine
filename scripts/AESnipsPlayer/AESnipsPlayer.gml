/*
This is where code for the SnipPlayer struct is placed.

A SnipPlayer is a struct that allows Snips to be played withouth being attached to any object and without relying on object properties like image_index or image_speed

Any time you see @private that means the variable or function is private and shouldn't be changed directly unless you know what you're doing
*/

/// @func SnipPlayer()
/// @desc Creates a new SnipPlayer that will play Snips
function SnipPlayer() constructor
{
	#region Instance variables
	/* ! Changing these values directly from other parts of the code could cause big problems ! */
	/* ! Please use the given Arbiter functions unless you know what you're doing ! */
	//These are all instance variables for the SnipPlayer

	/*@private*/ ae_snip_player_current_snip = undefined;	//The snip that is currently playing
	/*@private*/ ae_snip_player_current_loop = undefined;	//The loop that the Snip is currently playing
	/*@private*/ ae_snip_player_current_frame = -1;			//The frame that the Snip is currently on
	/*@private*/ ae_snip_player_next_snip = undefined;		//The snip that is set to play when the current snip finishes
	/*@private*/ ae_snip_player_is_paused = false;			//Whether or not the object playing the snip is paused
	/*@private*/ ae_snip_player_is_frozen = false;			//Whether or not the snip should has been frozen on the last frame
	/*@private*/ ae_snip_player_should_transition = false;	//Whether or not the snip should try to transition to the next snip
	/*@private*/ ae_snip_player_current_target = undefined;	//If a transition is splaying then this will hold the snip that the snip is supposed to transitioning to
	/*@private*/ ae_snip_player_loop_performances = [];		//How many times this loop has been repeated as the current snip is playing
	/*@private*/ ae_snip_player_changed = false;				//Whether or not the Snip has changed since the last step
	/*@private*/ ae_snip_player_image_index = 0;				//The frame of the sprite that should be drawn
	/*@private*/ ae_snip_player_image_speed = 0;				//The final speed that the Snip should be played at
	/*@private*/ ae_snip_player_snip_direction = 1;			//The direction (forwards:1 or backwards:-1) that the current Snip is being played at
	#endregion
	
	#region Step / Animation End functions
	/// @func step()
	/// @desc Call once every step to ensure that the Snip player is updating
	static step = function()
	{
		//Quit if there is no snip
		if (ae_snip_player_current_snip == undefined) { return; }
		//Continue with the script if there is an snip playing
	
		//Should be placed in the Step Event for each object that uses the snip system
		var _snip = ae_snip_player_current_snip; //Get the snip that is currently playing
		var _index = ae_snip_player_image_index; //Get the current image index
		var _start = ae_snip_player_current_snip.snip_frame_start;
		var _end = ae_snip_player_current_snip.snip_frame_end;
		
		//Whether or not the Snip is being played forward
		var _snip_forward = (ae_snip_player_snip_direction*_snip.snip_direction*_snip.snip_speed) > 0;
	
		//The frame speed for the Snip based on the index and start
		var _frame_speed = _snip.frame_speed[(_index - _start)];
	
		//Adjust the speed of the sprite depending on the following values
		//Frame Speed - Snip Speed - Snip Direction - Individual snip paused? - Individual Snip stopped? - All snips paused?
		ae_snip_player_image_speed = _frame_speed //The speed for the current snip's current frame
					* _snip.snip_speed //The speed for the whole current snip
					* _snip.snip_direction //Whether the Snip wants to be played forwards or backwards
					* ae_snip_player_snip_direction  //Whether the Snip is being played forwards or backwards by the SnipPlayer
					* !ae_snip_player_is_paused //If the snip is paused then this is 0, if not then it's 1
					* !ae_snip_player_is_frozen //If the snip is frozen at the end of an snip
					* !AE_SNIP_GLOBAL_IS_PAUSED; //If the snip system as a whole is paused

		//Find out what frame the Snip will be on next frame
		var _next_frame = _index + ( ae_snip_player_image_speed * _snip.snip_speed_scale);
		
		//Check to see if the Snip's next frame will go past the end or the start
		if ((_next_frame >= _end+1-math_get_epsilon() and _snip_forward)
		or (_next_frame <= _start and !_snip_forward))
		{			
			//Call the Snip End Event Script to simulate the end of a sprite animating
			self.animation_end();
			//Break out of this step script and restart next frame
			return;
		}
	
		//Before anything happens see if the snip is on a new frame
		if (floor(ae_snip_player_current_frame) != floor(ae_snip_player_image_index - _start)
		or ae_snip_player_changed)
		{
			//Make sure there is an Snip playing
			if (ae_snip_player_current_snip != undefined)
			{
				//Get the script for the current frame (undefined if there is no script)
				var _script = ae_snip_player_current_snip.frame_script[ae_snip_player_image_index - _start];
				//Get the argument set for the script
				var _arg = ae_snip_player_current_snip.frame_script_argument[ae_snip_player_image_index - _start];
		
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
			ae_snip_player_changed = false;
		}
	
		//This has to happen after checking whether or not a Snip is on a new frame
		ae_snip_player_current_frame = _index - _start; //Set the current frame to the image index

		//Only do this Snip logic if both the snip and the snip system are not paused
		if (!ae_snip_player_is_paused and !AE_SNIP_GLOBAL_IS_PAUSED and !ae_snip_player_is_frozen)
		{
			//If the snip has more than 0 loops
			if (ds_list_size(_snip.snip_loops) > 0)
			{
				//If the object isn't currently playing a loop
				if (ae_snip_player_current_loop == undefined)
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
						var _loop_done_performing = (ae_snip_player_loop_performances[_i] >= _current_loop.loop_repeat);
						//{bool} Find out if the system should just completely skip the loop
						var _loop_should_skip = (_current_loop.loop_repeat < 0 and ae_snip_player_loop_performances[_i] <=0);
					
						//No use the three bool variables to handle looping the snip properly
						if (_is_within_loop and (!_loop_done_performing or _loop_should_skip))
						{
							//If the loop should be skipped then skip it
							if (_loop_should_skip)
							{
								//Tell the loop that is has been performed
								ae_snip_player_loop_performances[_i] += 1;
							
								//If the Snip is being played forward
								if (_snip_forward)
								{
									//Jump to the end of the loop and skip everything inside the loop
									ae_snip_player_image_index = _current_loop.loop_end - _start;
								}
								else //If the Snip is being played backward
								{
									//Jump to the end of the loop and skip everything inside the loop
									ae_snip_player_image_index = _current_loop.loop_start - _start - math_get_epsilon();
								}
								break; //Break out of the repeat()
							}
							else //The loop should not skip
							{
								//Set the object's currently playing loop
								ae_snip_player_current_loop = _current_loop;
								ae_snip_player_current_loop_index = _i;
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
					var _currently_playing_loop = ae_snip_player_current_loop;
				
					//If the Snip has played past the end of the Loop
					var _snip_past_end = (_index - _start >= _currently_playing_loop.loop_end);
					//If the Snip has played past the start of the Loop (assuming it is being played backwards)
					var _snip_past_start = (_index - _start < _currently_playing_loop.loop_start);
				
					//If the Snip has reached the end of the loop (either forward or backward)
					if ((_snip_past_end and _snip_forward)
					or (_snip_past_start and !_snip_forward))
					{
						//Tell the loop that it has been performed by incrementing the variable
						ae_snip_player_loop_performances[ae_snip_player_current_loop_index] += 1;
					
						//If the Snip is being played forward
						if (_snip_forward)
						{
							//Set the current image index to the start of the Loop
							ae_snip_player_image_index = _currently_playing_loop.loop_start + _start;
						}
						else
						{
							//Set the current image index to the end of the Loop
							ae_snip_player_image_index = _currently_playing_loop.loop_end + _start - math_get_epsilon();
						}
					
						//If the loop has been repeated the proper number of times
						//Tell the object that it is no longer inside that loop
						if (ae_snip_player_loop_performances[ae_snip_player_current_loop_index] >= _currently_playing_loop.loop_repeat)
						{
							//Reset the current loop variable
							ae_snip_player_current_loop = undefined;
							ae_snip_player_current_loop_index = -1;
						}
					}
				}
			} // ^^ If the snip has more than 0 loops ^^			
			
			//Now change the image index to the next frame
			ae_snip_player_image_index += ae_snip_player_image_speed * ae_snip_player_current_snip.snip_speed_scale;
			
		} // ^^^ If the snip is actually playing ^^^ 
	}
	
	/// @func animation_end()
	/// @desc Mimic's the animation end event
	/// @private
	static animation_end = function()
	{
		//If there's not a Snip playing then just return false and skip the rest of the function
		if (ae_snip_player_current_snip == undefined)
		{
			return;
		}
	
		//If the Snip is currently in the middle of a loop
		if (ae_snip_player_current_loop != undefined)
		{
			//Whether or not the Snip is being played forward
			var _snip_forward = ae_snip_player_current_snip.snip_direction*ae_snip_player_snip_direction >= 0;
			//The starting frame of the Snip
			var _start = ae_snip_player_current_snip.snip_frame_start;
		
			//Tell the loop that it has been performed by incrementing the variable
			ae_snip_player_loop_performances[ae_snip_player_current_loop_index] += 1;
					
			//If the Snip is being played forward
			if (_snip_forward)
			{
				//Set the current image index to the start of the Loop
				ae_snip_player_image_index = ae_snip_player_current_loop.loop_start + _start;
			}
			else
			{
				//Set the current image index to the end of the Loop
				ae_snip_player_image_index = ae_snip_player_current_loop.loop_end + _start - math_get_epsilon();
			}
					
			//If the loop has been repeated the proper number of times
			//Tell the object that it is no longer inside that loop
			if (ae_snip_player_loop_performances[ae_snip_player_current_loop_index] >= ae_snip_player_current_loop.loop_repeat)
			{
				//Reset the current loop variable
				ae_snip_player_current_loop = undefined;
				ae_snip_player_current_loop_index = -1;
			}
		
			//Return to skip the rest of the function
			return;
		}
	
		//We know a Snip is playing
		//If the Snip's end type is a pingpong_first, we reverse the animation speed and skip the rest
		if (ae_snip_player_current_snip.snip_end_type = ae_snip_end.end_pingpong_head)
		{
			//Check to see if the Snip is playing forwards
			if (snip_get_speed(ae_snip_player_current_snip) * snip_get_direction(ae_snip_player_current_snip)*ae_snip_player_snip_direction > 0)
			{
				//Set the image_index to the last frame possible
				ae_snip_player_image_index = ae_snip_player_current_snip.snip_frame_end + (1 - math_get_epsilon());
				//Tell the player to start playing the Snip in the opposite direction
				ae_snip_player_snip_direction = -ae_snip_player_snip_direction;
				//Reset the loops
				self.snip_reset_loops(ae_snip_player_current_snip);
				//Return so the Snip never actually "completes"
				return;
			}
		}
		//If the Snip's end type is a pingpong_last, we reverse the animation speed and skip the rest
		if (ae_snip_player_current_snip.snip_end_type = ae_snip_end.end_pingpong_tail)
		{
			//Check to see if the Snip is playing backwards
			if (snip_get_speed(ae_snip_player_current_snip) * snip_get_direction(ae_snip_player_current_snip)*ae_snip_player_snip_direction < 0)
			{
				//Make sure to jump to the start
				ae_snip_player_image_index = ae_snip_player_current_snip.snip_frame_start; //Reset the image_index to the start 
				//Tell the player to start playing the Snip in the opposite direction
				ae_snip_player_snip_direction = -ae_snip_player_snip_direction;
				//Reset the loops
				self.snip_reset_loops(ae_snip_player_current_snip);
				//Return so the Snip never actually "completes"
				return;
			}
		}
	
		//If there is a script/method to execute then allow execute it
		if (ae_snip_player_current_snip.snip_complete_script != undefined)
		{
			//If the script is a method
			if (is_method(ae_snip_player_current_snip.snip_complete_script))
			{
				//Execute it as a method with the argument
				ae_snip_player_current_snip.snip_complete_script(ae_snip_player_current_snip.snip_complete_script_argument);
			}
			else //If it's not a method
			{
				//Execute it as a script with the argument
				script_execute(ae_snip_player_current_snip.snip_complete_script, ae_snip_player_current_snip.snip_complete_script_argument);
			}
		}
	
		//If there's a next snip that should be played and it's not the same snip
		if (ae_snip_player_next_snip != ae_snip_player_current_snip and ae_snip_player_next_snip != undefined)
		{
			//Play the snip and use the transition if desired
			self.snip_play(ae_snip_player_next_snip, ae_snip_player_should_transition)
		}
		else
		{
			//If there isn't a next snip to play then look for a successor to the current snip
			if (ae_snip_player_next_snip == undefined)
			{
				//Get the follow-up Snip and should_transition value
				var _follower = ae_snip_player_current_snip.snip_successor;
				var _follower_transition = ae_snip_player_current_snip.snip_successor_transition;
			
				//If there is a follow-up Snip
				if (_follower != undefined)
				{
					//Then play it immediately with the snip's successor transition variable
					self.snip_play(_follower, _follower_transition);
				}
				else
				{
					switch (ae_snip_player_current_snip.snip_end_type)
					{
						case ae_snip_end.end_repeat:
							//If the Snip is being played forwards
							if (ae_snip_player_current_snip.snip_direction*ae_snip_player_snip_direction >= 0)
							{
								//Just loop the Snip by going back to the start
								ae_snip_player_image_index = ae_snip_player_current_snip.snip_frame_start; //Reset the image_index to the start 
							}
							else //If the Snip is being played backwards
							{
								//Just loop the Snip by going to the end of the final frame (as close to snip_frame_end+1 as possible)
								ae_snip_player_image_index = ae_snip_player_current_snip.snip_frame_end + (1 - math_get_epsilon());
							}
							ae_snip_player_current_frame = ae_snip_player_image_index; //Set the current frame to the image index
							ae_snip_player_current_loop = undefined; //Reset the loop value
							ae_snip_player_current_loop_index = -1; //Reset the loop index
							ae_snip_player_changed = true; //Tell the object that the snip has changed because it has looped back					
							self.snip_reset_loops(ae_snip_player_current_snip); //Reset the loops
						break;
						case ae_snip_end.end_stop:
							ae_snip_player_image_speed = 0; //Freeze the image_speed so it stays on that index
							ae_snip_player_current_frame = ae_snip_player_image_index; //Set the current frame to the image index
							ae_snip_player_is_frozen = true; //Freeze the Snip so it won't keep repeating
						break;
						case ae_snip_end.end_stop_tail:
							//Set the Snip to the very last frame
							ae_snip_player_image_index = ae_snip_player_current_snip.snip_frame_end; //Make sure the image is on the last frame 
							ae_snip_player_image_speed = 0; //Freeze the image_speed so it stays on that index
							ae_snip_player_current_frame = ae_snip_player_image_index; //Set the current frame to the image index
							ae_snip_player_is_frozen = true; //Freeze the Snip so it won't keep repeating
						break;					
						case ae_snip_end.end_stop_head:
							//Jump back to the first frame and freeze
							ae_snip_player_image_index = ae_snip_player_current_snip.snip_frame_start; //Make sure the image is on the first frame 
							ae_snip_player_image_speed = 0; //Freeze the image_speed so it stays on that index
							ae_snip_player_current_frame = ae_snip_player_image_index; //Set the current frame to the image index
							ae_snip_player_is_frozen = true; //Freeze the Snip so it won't keep repeating
						break;
						//If the Snip should pingpong
						case ae_snip_end.end_pingpong:
						case ae_snip_end.end_pingpong_head:
						case ae_snip_end.end_pingpong_tail:
							var _is_forward = (snip_get_speed(ae_snip_player_current_snip)
												* snip_get_direction(ae_snip_player_current_snip)
												* ae_snip_player_snip_direction) > 0;
							//If the Snip is being played backwards in the pingpong
							if (!_is_forward)
							{
								//Make sure to jump to the start
								ae_snip_player_image_index = ae_snip_player_current_snip.snip_frame_start; //Reset the image_index to the start 
								//Reverse the direction that the SnipPlayer is playing the Snip at
								ae_snip_player_snip_direction = -ae_snip_player_snip_direction;
							}
							else //If the Snip is being played forwards
							{
								//Set the image_index to the last frame possible
								ae_snip_player_image_index = ae_snip_player_current_snip.snip_frame_end + (1 - math_get_epsilon());
								//Reverse the direction that the SnipPlayer is playing the Snip at
								ae_snip_player_snip_direction = -ae_snip_player_snip_direction;
							}
							//Clear the image speed
							ae_snip_player_image_speed = 0;
							//Reset the Snip's current frame
							ae_snip_player_current_frame = ae_snip_player_image_index; //Set the current frame to the image index
							//Reset the loops
							self.snip_reset_loops(ae_snip_player_current_snip);
						break;
					}
				}
			}
			else
			{
				//If the Snip should just play itself again
				self.snip_play(ae_snip_player_current_snip, false);
			}
		}
	}
	#endregion
	
	#region Drawing functions
	/// @func draw(x,y)
	/// @desc Draws the SnipPlayers currently playing Snip at the given location
	/// @param {Real} x The x position to draw at
	/// @param {Real} y The y position to draw at
	static draw = function(_x,_y)
	{
		//Ask to make sure the SnipPlayer is actually playing a Snip
		if (ae_snip_player_current_snip != undefined)
		{
			var _sprite = ae_snip_player_current_snip.snip_sprite;
			//Draw the sprite if there is a sprite
			if (_sprite != undefined)
			{
				draw_sprite(_sprite, ae_snip_player_image_index, _x, _y);
			}
		}
	}
	
	/// @func draw_ext(x,y,xscale,yscale,rot,col,alpha)
	/// @desc Draws the SnipPlayers currently playing Snip at the given location
	/// @param {Real} x The x position to draw at
	/// @param {Real} y The y position to draw at
	/// @param {Real} xscale The x scale to draw with
	/// @param {Real} yscale The y scale to draw with
	/// @param {Real} rot The angle to draw at
	/// @param {Color} col The color to draw with
	/// @param {Real} alpha The alpha to draw with
	static draw_ext = function(_x, _y, _xscale, _yscale, _rotation, _color, _alpha)
	{
		//Ask to make sure the SnipPlayer is actually playing a Snip
		if (ae_snip_player_current_snip != undefined)
		{
			var _sprite = ae_snip_player_current_snip.snip_sprite;
			//Draw the sprite if there is a sprite
			if (_sprite != undefined)
			{
				draw_sprite_ext(_sprite, ae_snip_player_image_index, _x, _y, _xscale, _yscale, _rotation, _color, _alpha);
			}
		}
	}
	#endregion
	
	#region Playback functions
	
	///@function snip_play(snip, should_transition)
	///@desc Immediately plays the given snip with or without transition
	///@param {Snip} snip The Snip that the SnipPlayer should play
	///@param {bool} should_transition Whether or not the SnipPlayer should try to find a transition between the current snip and the snip to play
	static snip_play = function(_snip, _should_transition)
	{
		//Unfreeze the Snip any time a new Snip is played
		ae_snip_player_is_frozen = false;
		
		//Reset the direction that the player should play the Snip at
		ae_snip_player_snip_direction = 1;
	
		//If the given Snip is different than the current Snip, set the Snip as changed
		if (_snip != ae_snip_player_current_snip)
		{
			ae_snip_player_changed = true;
		}
	
		//By default use the given snip as the Snip to play
		var _play_snip = _snip;
		//By default there should be no next Snip
		var _next_snip = undefined;
	
		//If the system should search for a transition and there is an snip currently playing
		if (_should_transition and ae_snip_player_current_snip != undefined)
		{
			//When looking for the transition use the current Snip as the "from"
			var _from = ae_snip_player_current_snip;
		
			//If the Snip is currently transitioning to another Snip then use the target as the "from"
			if (ae_snip_player_current_target != undefined)
			{
				_from = ae_snip_player_current_target;
			}
		
			//Reset the target variable here
			ae_snip_player_current_target = undefined;
		
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
				ae_snip_player_current_target = _snip;
			}
		}
		else //If the system should not search for a transition then clear the target
		{
			ae_snip_player_current_target = undefined;
		}
	
		ae_snip_player_current_snip = _play_snip; //Set the current snip
		ae_snip_player_next_snip = _next_snip; //Reset the next snip
		ae_snip_player_current_loop = undefined; //Reset the current loop
		ae_snip_player_sprite_index = _play_snip.snip_sprite; //Set the proper sprite index
	
		//If the next Snip will be played forwards
		if (_play_snip.snip_direction >= 0)
		{
			//Set the index to the start
			ae_snip_player_image_index = _play_snip.snip_frame_start;
			//Stop the animation for just a moment
			ae_snip_player_image_speed = 0;
		}
		else //If the next Snip will be played backwards
		{
			//Set the index to the end 
			ae_snip_player_image_index = ae_snip_player_current_snip.snip_frame_end + (1 - math_get_epsilon());
			//Stop the animation for just a moment
			ae_snip_player_image_speed = 0;
		}
	
		ae_snip_player_current_frame = ae_snip_player_image_index;
	
		//Reset all the loop counters in the object
		if (ae_snip_player_current_snip != undefined)
		{
			self.snip_reset_loops(ae_snip_player_current_snip);
		}
	}
	
	///@func snip_start(snip)
	///@desc Starts the snip system with the given snip
	///@param {Snip} snip The snip to start with
	static snip_start = function(_snip)
	{
		self.snip_play(_snip, false);
	}
	
	///@function snip_play_next(snip, should_transition)
	///@desc Sets an snip to play as soon as the current snip is done playing
	///@param {Snip} snip The snip to play
	///@param {bool} should_transition Whether or not the system should try to find a transition between the current snip and the snip to play
	static snip_play_next = function(_snip, _should_transition)
	{
		//If there isn't an Snip playing right now
		if (ae_snip_player_current_snip == undefined or ae_snip_player_is_frozen)
		{
			//Just play the snip now
			self.snip_play(_snip, _should_transition);
		}
		else
		{
			//Set the snip to play on the Snip End
			ae_snip_player_next_snip = _snip;
			ae_snip_player_should_transition = _should_transition;
		}
	}
	
	///@func snip_cancel_play_next()
	///@desc This will cancel the Snip that the object has queued to play next
	static snip_cancel_play_next = function()
	{
		//If the Snip is transitioning then the current target will have a Snip
		//So this will play the Snip that is being transitioned to
	
		//But if the Snip is not transitioning then the current target will be undefined
		//So this will clear the next Snip value
		ae_snip_player_next_snip = ae_snip_player_current_target;
		ae_snip_player_should_transition = false;
	}
	
	///@func snip_reset_loops(snip)
	///@desc Resets the performance count in all the loops in the given snip
	///@param {Snip} snip The snip that the loops are a part of
	static snip_reset_loops = function(_snip)
	{	
		//Clear out the performance array
		ae_snip_player_loop_performances = [];
	
		//Loop through all the loops in the given snip
		var _i =0;
		repeat(ds_list_size(_snip.snip_loops))
		{
			//Tell the loop that it has been performed 0 times
			ae_snip_player_loop_performances[_i] = 0;
			_i += 1;
		}
	}
	
	///@func snip_pause()
	///@desc Pauses the Snip that the object is currently playing
	static snip_pause = function()
	{
		ae_snip_is_paused = true;
	}

	///@func snip_resume()
	///@desc Un-pauses the Snip that the object is currently playing
	static snip_resume = function()
	{
		ae_snip_is_paused = false
	}
	
	///@func snip_stop_tail()
	///@desc Stops the Snip that the object is currently playing and jumps to the last frame (as if the end_type is end_stop)
	static snip_stop_tail = function()
	{
		//Set the Snip to the very last frame
		ae_snip_player_image_index = ae_snip_player_current_snip.snip_frame_end; //Make sure the image is on the last frame 
		ae_snip_player_image_speed = 0; //Freeze the image_speed so it stays on that index
		ae_snip_player_current_frame = ae_snip_player_image_index; //Set the current frame to the image index
		ae_snip_player_is_frozen = true; //Freeze the Snip so it won't keep repeating
	}
	
	///@func snip_stop_head()
	///@desc Stops the Snip that the object is currently playing and reloads it to the first frame (as if the end_type is end_stop_beginning)
	static snip_stop_head = function()
	{
		//Jump back to the first frame and freeze
		ae_snip_player_image_index = ae_snip_player_current_snip.snip_frame_start; //Make sure the image is on the first frame 
		ae_snip_player_image_speed = 0; //Freeze the image_speed so it stays on that index
		ae_snip_player_current_frame = ae_snip_player_image_index; //Set the current frame to the image index
		ae_snip_player_is_frozen = true; //Freeze the Snip so it won't keep repeating	
	}

	///@func snip_stop()
	///@desc Stops the Snip that the object is currently playing and keep it on the same frame
	static snip_stop = function()
	{
		ae_snip_player_image_speed = 0; //Freeze the image_speed so it stays on that index
		ae_snip_player_current_frame = ae_snip_player_image_index; //Set the current frame to the image index
		ae_snip_player_is_frozen = true; //Freeze the Snip so it stops completely
	}

	///@func snip_play_request(snip, transition)
	///@desc Only plays the given Snip if it is not already playing
	///@param {Snip} snip The Snip you would like to play
	///@param {bool} should_transition Whether or not to Transition when playing the Snip
	static snip_play_request = function(_snip, _should_transition)
	{
		//Only play the Snip if it is not currently playing
		if (!self.snip_is_playing(_snip, true))
		{
			self.snip_play(_snip, _should_transition);
		}
	}
	
	#endregion
}