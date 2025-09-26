/// @description Increases the player's ring count by the given amount.
/// @param {Real} amount Number of rings to give.
function player_get_rings(amount)
{
	var total = objGameData.player_rings + amount;
	
	// Get lives
	if (total <= 999)
	{
		var change = (objGameData.player_rings mod 100) + amount;
		if (change >= 100) player_get_lives(change div 100);
	}
	
	// Get rings
	objGameData.player_rings = min(total, 999);
	
	// Sound
	audio_play_sfx(sfxRing);
}

/// @description Increases the player's life count by the given amount.
/// @param {Real} amount Number of lives to give.
function player_get_lives(amount)
{
	objGameData.player_lives = min(objGameData.player_lives + amount, 99);
	audio_play_jingle(bgmLife);
}

/// @description Spawns up to 32 dropped rings in circles of 16 at the player's coordinates, and resets their ring count.
function player_drop_rings()
{
	// Loop until no rings remain
	var spd = 4;
	var dir = 101.25;
	for (var ring = min(objGameData.player_rings, 32); ring > 0; --ring)
	{
		if (ring == 16)
		{
			spd = 2;
			dir = 101.25;
		}
		with (instance_create_layer(x, y, layer, objRingDropped))
		{
			gravity_direction = other.gravity_direction;
			image_angle = gravity_direction;
			x_speed = lengthdir_x(spd, dir);
			y_speed = lengthdir_y(spd, dir);
			if (ring mod 2 != 0)
			{
				x_speed *= -1;
				dir += 22.5;
			}
		}
	}
	
	// Reset ring count
	objGameData.player_rings = 0;
	
	// Sound
	audio_play_sfx(sfxRingLoss);
}

/// @description Handles the player's condition upon taking damage.
/// @param {Real} obj Object or instance the player should recoil from.
/// @returns {Bool} Whether or not the player's state should be aborted.
function player_get_hit(obj)
{
	// Abort if already invulnerable in any way
	if (state == player_is_hurt or recovery_time > 0 or invincibility_time > 0) return false;
	
	// Drop rings and recoil, if applicable
	if (objGameData.player_rings > 0)
	{
		player_drop_rings();
		player_is_hurt(-1);
		
		// Movement
		x_speed = 2 * sign(x - obj.x);
		if (x_speed == 0) x_speed = 2;
		y_speed = -4;
	}
	else player_is_dead(-1); // Otherwise, die
	return true;
}

/// @description Checks if the player can lock on to the given instance for a homing attack.
/// @param {Id.Instance} obj Object or instance to check.
/// @returns {Bool}
function player_can_lock_on(obj)
{
	// Abort if the instance is far away
	if (point_distance(x, y, obj.x, obj.y) > 128) return false;
	
	// Abort on an indirect line of sight
	with (obj)
	{
		if (collision_line(x, y, other.x, other.y, objSolid, false, true) != noone)
		{
			return false;
		}
	}
	
	// Check against rotation
	switch (mask_direction)
	{
		case 0:
		{
			if (sign(obj.x - x) != image_xscale or y >= obj.y) return false;
			break;
		}
		case 90:
		{
			if (sign(y - obj.y) != image_xscale or x >= obj.x) return false;
			break;
		}
		case 180:
		{
			if (sign(x - obj.x) != image_xscale or y <= obj.y) return false;
			break;
		}
		case 270:
		{
			if (sign(obj.y - y) != image_xscale or x <= obj.x) return false;
			break;
		}
	}
	
	// Lock-on is possible
	return true;
}