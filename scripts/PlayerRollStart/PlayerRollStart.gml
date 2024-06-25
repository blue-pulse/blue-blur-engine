function PlayerRollStart()
{
	if !ForcedRoll and (input_check("btn_left") or input_check("btn_right")) or SpindashRev != -1
	{
		return;
	}
	
	// Check if we should roll up
	var ManualRoll = false;
	if  input_check("btn_down")
	{
		if global.SKCrouch
		{
			if abs(Gsp) >= 1
			{
				ManualRoll = true;
			}
			else
			{
				Animation = AnimCrouch;
			}
		}
		else if abs(Gsp) >= 0.5
		{
			ManualRoll = true;
		}
	}
	
	// Roll up
	if ManualRoll or ForcedRoll
	{
		PosY     += DefaultRadiusY - SmallRadiusY;
		RadiusY   = SmallRadiusY;
		RadiusX	  = SmallRadiusX;
		Spinning  = true;
		Animation = AnimSpin;
	}
}