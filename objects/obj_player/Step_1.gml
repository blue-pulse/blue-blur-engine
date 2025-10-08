// Count down timers
if (gnd_lock > 0 and is_grounded)
{
	--gnd_lock;
}
if (recovery_timer > 0)
{
	image_alpha = (--recovery_timer mod 8 < 4); // Flash on-and-off every 4 steps
}
if (invincibility_timer > 0 and --invincibility_timer <= 0)
{
	instance_destroy(invincibility_effect);
	invincibility_effect = noone;
	audio_dequeue_bgm(bgmInvincibility, true);
}
if (superspeed_timer > 0 and --superspeed_timer <= 0)
{
	player_update_physics();
}