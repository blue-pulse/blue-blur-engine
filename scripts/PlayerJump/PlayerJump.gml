function PlayerJump()
{
	if !is_jumping
	{
		return;
	}
	
	if !button_check("btn_1")
	{
		// Shorten jump force
		if vertical_speed < min_jump_height
		{
			vertical_speed = min_jump_height;
		}
	}
	
	/* Everything below is special mid-jump actions */
	
	if vertical_speed < min_jump_height or !button_check_pressed("btn_1")
	{
		return;
	}
}