/* AUTHOR NOTE: a reaction should cause the player's state to be aborted if the following conditions are met:
> The player has changed state (we don't want to keep performing actions from our previous state.)

Solid objects only:
> The player has rebounded vertically (we don't want to land on the solid.)
> The solid is destroyed (an error will occur otherwise as the game is attempting to register the solid as the player's current wall/ground/ceiling.)

If any of the conditions above are met, the reaction function MUST return true, otherwise it should return false. */

/// @description Executes the reaction function of the given instance in context of the player.
/// @param {Id.Instance} obj Object or instance to check.
/// @param {Real} [side] Direction of collision to check (optional, unused for non-solid objects.)
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_react(obj, side)
{
	var reaction = obj.reaction_index;
	if (reaction == -1) return false;
	return (side == undefined) ? reaction(obj) : reaction(obj, side);
}

/// @description Handles how the player should react upon collision with the given ring instance.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_reaction_ring(obj)
{
	// Ignore if hit or starting to recover
	if (state == player_is_hurt or recovery_time > 90) return false;
	
	// Collect ring
	player_get_rings(1);
	
	// Ring sparkle
	part_particles_create(objResources.particles, obj.x, obj.y, objResources.ring_sparkle, 1);
	
	// Destroy ring
	instance_destroy(obj);
	
	// Do not abort state
	return false;
}

/// @description Handles how the player should react upon collision with the given badnik instance.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_reaction_badnik(obj)
{
	// Take damage if not in an attacking state
	if (not (spinning or invincibility_time > 0))
	{
		// Abort state if successful
		return player_get_hit(obj);
	}
	
	// Rebound in air
	var homing_rebound = false;
	if (state == player_is_homing)
	{
		// Stop moving and bounce
		state = player_is_falling;
		x_speed = 0;
		y_speed = -jump_height div 1;
		homing_rebound = true;
	}
	else if (not on_ground)
	{
		// Weigh down slightly
		if (y_speed < 0 and collision_box_vertical(x_radius, -y_radius, mask_direction, obj) != noone)
		{
			++y_speed;
		}
		else if (y_speed >= 0 and collision_box_vertical(x_radius, y_radius, mask_direction, obj) != noone)
		{
			// Bounce
			y_speed *= -1;
		}
	}
	
	// Scoring
	var bonus = 100;
	var index = 1;
	
	if (++score_combo > 15)
	{
		bonus = 10000;
		index = 5;
	}
	else if (score_combo > 3)
	{
		bonus = 1000;
		index = 4;
	}
	else if (score_combo > 2)
	{
		bonus = 500;
		index = 3;
	}
	else if (score_combo > 1)
	{
		bonus = 200;
		index = 2;
	}
	
	objGameData.player_score += bonus;
	instance_create_layer(obj.x, obj.y, "Overlays", objPoints, { image_index : index });
	
	// Sound
	audio_play_sfx(sfxDestroy);
	
	// Destroy badnik and reticle
	instance_destroy(objReticle);
	instance_destroy(obj);
	
	// Abort state if rebounded from a homing attack
	return homing_rebound;
}

/// @description Handles how the player should react upon collision with the given projectile instance.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_reaction_projectile(obj)
{
	// Take damage; abort state if successful
	return player_get_hit(obj);
}

/// @description Handles how the player should react upon collision with the given layer flipping instance.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_reaction_layer_flip(obj)
{
	// Flip layer if on ground
	if (on_ground) collision_layer = (sign(obj.image_xscale) != sign(x - xprevious));
	
	// Do not abort state
	return false;
}

/// @description Handles how the player should react upon collision with the given layer setting instance.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_reaction_layer_set(obj)
{
	// Set layer according to scale
	collision_layer = (obj.image_xscale < 0);
	
	// Do not abort state
	return false;
}

/// @description Handles how the player should react upon collision with the given dash panel instance.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_reaction_dash_panel(obj)
{
	// Ignore if airborne, the dash panel is already triggered, or we're not inside it
	if (not on_ground or obj.alarm[0] != -1 or
		not point_in_rectangle(x, y, obj.bbox_left, obj.bbox_top, obj.bbox_right, obj.bbox_bottom))
	{
		return false;
	}
	
	// Trigger
	obj.alarm[0] = 5;
	audio_play_sfx(sfxPeelout);
	
	// Launch
	image_xscale = obj.image_xscale;
	x_speed = max(abs(x_speed), 12) * image_xscale;
	control_lock_time = 16;
	
	// Roll, if applicable
	if (obj.force_roll and state != player_is_rolling)
	{
		// Abort state
		player_is_rolling(-1);
		return true;
	}
	
	// Do not abort state
	return false;
}

/// @description Handles how the player should react upon collision with the given monitor instance.
/// @param {Id.Instance} obj Object or instance to check.
/// @param {Real} side Direction of collision to check.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_reaction_monitor(obj, side)
{
	// Top collision
	if (side == DIR_TOP)
	{
		// Knock down monitor
		obj.vspeed = -2;
		obj.gravity = 0.21875;
		
		// The monitor is too flat to land on; no need to abort state
		return false;
	}
	
	// Ignore if...
	if (y_speed < 0 or not spinning) return false; // Moving upwards or not spinning
	if (side == DIR_BOTTOM and on_ground) return false; // Spinning on top of the monitor
	
	// Rebound in air
	if (state == player_is_homing)
	{
		state = player_is_falling;
		x_speed = 0;
		y_speed = -jump_height div 1;
	}
	else if (not on_ground)
	{
		y_speed *= -1;
	}
	
	// Create icon
	with (instance_create_layer(obj.x, obj.y - 5, layer, objMonitorIcon))
	{
		image_index = obj.icon_index;
		player_id = other.id;
	}
	
	// Sound
	audio_play_sfx(sfxDestroy);
	
	// Destroy monitor and reticle
	instance_destroy(objReticle);
	instance_destroy(obj);
	
	// Abort state
	return true;
}

/// @description Handles how the player should react upon collision with the given spring instance.
/// @param {Id.Instance} obj Object or instance to check.
/// @param {Real} side Direction of collision to check.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_reaction_spring(obj, side)
{
	// Get orientation relative to current rotation
	var rotation_offset = angle_wrap(obj.image_angle - mask_direction);
	
	// Ignore if not touching the correct side
	if ((side == DIR_RIGHT and rotation_offset != 90) or
		(side == DIR_LEFT and rotation_offset != 270) or
		(side == DIR_BOTTOM and rotation_offset != 0) or
		(side == DIR_TOP and rotation_offset != 180)) return false;
	
	// Get movement vectors
	var x_spring_speed = -dsin(rotation_offset) * obj.force;
	var y_spring_speed = -dcos(rotation_offset) * obj.force;
	
	// Bounce from spring
	if (x_spring_speed != 0)
	{
		x_speed = x_spring_speed;
		image_xscale = sign(x_speed);
		control_lock_time = 16;
	}
	if (y_spring_speed != 0)
	{
		// Set state
		player_is_falling(-1);
		
		// Movement
		y_speed = y_spring_speed;
		
		// Set flags and animate if rising
		if (side == DIR_BOTTOM)
		{
			spinning = false;
			jumping = false;
			animation_index = "rise";
			image_angle = gravity_direction;
		}
	}
	
	// Animate spring
	obj.image_index = 0;
	obj.alarm[0] = 1;
	
	// Sound
	audio_play_sfx(sfxSpring);
	
	// Abort state only if bouncing vertically
	return (y_spring_speed != 0);
}

/// @description Handles how the player should react upon collision with the given spike instance.
/// @param {Id.Instance} obj Object or instance to check.
/// @param {Real} side Direction of collision to check.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_reaction_spike(obj, side)
{
	// Get orientation relative to current rotation
	var rotation_offset = angle_wrap(obj.image_angle - mask_direction);
	
	// Ignore if not touching the correct side
	if ((side == DIR_RIGHT and rotation_offset != 90) or
		(side == DIR_LEFT and rotation_offset != 270) or
		(side == DIR_BOTTOM and rotation_offset != 0) or
		(side == DIR_TOP and rotation_offset != 180)) return false;
	
	// Take damage; abort state if successful
	return player_get_hit(obj);
}