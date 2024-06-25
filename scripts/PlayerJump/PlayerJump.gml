function PlayerJump()
{
	if !Jumping
	{
		return;
	}
	
	if !input_check("btn_1")
	{
		// Shorten jump force
		if Ysp < JumpMin
		{
			Ysp = JumpMin;
		}
	}
	
	/* Everything below is special mid-jump actions */
	
	if Ysp < JumpMin or !input_check_pressed("btn_1")
	{
		return;
	}
}