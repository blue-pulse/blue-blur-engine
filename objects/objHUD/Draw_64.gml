/// @description Render HUD

// Lives setpiece
draw_sprite(sprLifeIcon, 0, 16, SCREEN_HEIGHT - 24);

// Score/Time/Rings setpieces
draw_sprite(sprHUD, 0, 16, 9);
if (objStage.stage_time < 32400 or image_index mod 2 != 0) // 32400 steps = 9 minutes
{
	draw_sprite(sprHUD, 1, 16, 25);
}
if (objGameData.player_rings > 0 or image_index mod 2 != 0)
{
	draw_sprite(sprHUD, 2, 16, 41);
}

// Lives text
draw_set_halign(fa_right);
draw_set_font(objResources.font_lives);
draw_text(64, SCREEN_HEIGHT - 15, objGameData.player_lives);

// Score/Time/Rings text
draw_set_font(objResources.font_hud);
draw_text(112, 9, objGameData.player_score);
draw_text(88, 41, objGameData.player_rings);
draw_set_halign(fa_left);
draw_text(56, 25, timestamp);

// Power-up bars
with (objPlayer)
{
	if (superspeed_time > 0)
	{
		draw_sprite(sprMonitorIcon, 1, 24, 65);
		draw_healthbar(32, 58, 110, 71, superspeed_time div 12, c_red, c_red, c_red, 0, false, false);
	}
	if (invincibility_time > 0)
	{
		var oy = 21 * (superspeed_time > 0);
		draw_sprite(sprMonitorIcon, 2, 24, 65 + oy);
		draw_healthbar(32, 58 + oy, 110, 71 + oy, invincibility_time div 12, c_white, c_white, c_white, 0, false, false);
	}
}