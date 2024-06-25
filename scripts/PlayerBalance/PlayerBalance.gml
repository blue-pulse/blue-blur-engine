function PlayerBalance()
{
	if ground_speed != 0
	{
		return;
	}
	
	// Balance subfunctions
	#region SubFunctions
	{
		// @subfunction PlayerBalanceLeft(panicCondition)
		function PlayerBalanceLeft(panicCondition)
		{
			if facing == left
			{
				state = states.AnimBalance;
			}
			else if facing == right
			{
				state = states.AnimBalanceFlip;
			}
			
			// Play additional animations for Sonic
			if global.Character == CharSonic and !SuperState
			{
				if panicCondition
				{
					if facing == right
					{
						state = states.AnimBalanceTurn;
						facing	  = left;
					}
					else
					{
						state = states.AnimBalancePanic;
					}
				}
			}
		}
		
		// @subfunction PlayerBalanceRight(panicCondition)
		function PlayerBalanceRight(panicCondition)
		{
			if facing == right
			{
				state = states.AnimBalance;
			}
			else if facing == left
			{
				state = states.AnimBalanceFlip;
			}
			
			// Play additional animations for Sonic
			if global.Character == CharSonic and !SuperState
			{
				if panicCondition
				{
					if facing == left
					{
						state = states.AnimBalanceTurn;
						facing	  = right;
					}
					else
					{
						state = states.AnimBalancePanic;
					}
				}
			}
		}
	}
	#endregion
	
	// Balance on the floor
	if !OnObject
	{
		if global.SKCrouch and button_check("btn_down")
		{
			return;
		}
		if angle >= 46.41 and angle <= 313.59
		{
			return;
		}
		
		// Check for floor
		var FindFloor = tile_find_v(pos_x, pos_y + radius_y, true, plane)[0];	
		if  FindFloor < 12
		{
			return;
		}
		
		// Get floor angles and continue if only one exists
		var FindAngle1 = tile_find_v(pos_x - radius_x, pos_y + radius_y, true, plane)[1];
		var FindAngle2 = tile_find_v(pos_x + radius_x, pos_y + radius_y, true, plane)[1];
		
		if !(FindAngle1 and !FindAngle2 or !FindAngle1 and FindAngle2)
		{
			return;
		}
		
		// Balance!
		if !FindAngle1
		{	
			PlayerBalanceLeft(tile_find_v(pos_x + 6, pos_y + radius_y, true, plane)[0] >= 12);
		}
		else if !FindAngle2
		{
			PlayerBalanceRight(tile_find_v(pos_x - 6, pos_y + radius_y, true, plane)[0] >= 12);
		}
	}
	
	// Balance on the object
	else
	{
		/* In orginals, the widest balance range varies from 
		object to object (2 to 4). We'll use a range of 2 pixels */
		var Tolerance = 2;
		
		// Ignore specific objects
		/*
		if OnObject.object_index == Bridge
		{
			return;
		}
		*/
		
		// Get balance range
		var PlayerX   = OnObject.Obj_SolidX - OnObject.x + floor(pos_x);
		var RightEdge = OnObject.Obj_SolidX * 2 - 1;
		
		// Balance!
		if PlayerX < Tolerance
		{
			PlayerBalanceLeft(PlayerX < -Tolerance);
		}
		else if PlayerX > RightEdge - Tolerance
		{
			PlayerBalanceRight(PlayerX > RightEdge + Tolerance);
		}
	}
}