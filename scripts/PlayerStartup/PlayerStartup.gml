function PlayerStartup()
{		
	// Initialise variables
	pos_x				= 0;
	pos_y				= 0;
	accel				= 0;
	GlideAcc			= 0;
	decel					= 0;
	frict					= 0;
	roll_frict				= 0;
	air_accel				= 0;
	roll_decel				= 0;
	jump_height				= 0;
	min_jump_height				= 0;
	top_accel				= 0;
	horizontal_speed					= 0;
	vertical_speed					= 0;
	ground_speed					= 0;
	slope_gravity        = 0;
	angle				= 0;
	ground_lock			= 0;
	air_lock				= 0;
	forced_roll			= 0;
	is_rolling			= 0;
	is_jumping				= 0;
	is_pushing             = 0;
	is_grounded		    = 0;
	on_object			= 0;
	PeeloutForce        = 0;
	DropdashSide	    = 0;
	SuperState			= 0;
	SuperStateValue	    = 0;
	GlideState			= 0;
	GlideValue			= 0;
	GlideSpeed			= 0;
	GlideDirection	    = 0;
	GlideFrame			= 0;
	ClimbState			= 0;
	ClimbValue			= 0;
	FlightState			= 0;
	FlightValue			= 0;
	HighspeedBonus	    = 0;
	InvincibleBonus	    = 0;
	InvincibilityFrames = 0;
	is_underwater	    = 0;
	BarrierType			= 0;
	BarrierIsActive     = 0;
	stick_to_convex	    = 0;
	is_being_hurt				= 0;
	Death				= 0;
	Drown				= 0;
	ScoreCombo			= 0;	
	plane				= 0;
	rotation			= 0;
	Animation			= 0;
	Rings				= 0;
	DebugMode           = 0;
	DebugItem			= 0;
	DebugSpeed			= 0;
	hitbox			= [];
	
	// Set defaults
	allow_collision   = true;
	allow_movement    = true;
	DropdashRev      = -1;
	PeeloutRev       = -1;
	spindash_revolutions      = -1;
	gravity_force			     = 0.21875;
	AirTimer	     = 1800;
	collision_mode    = [0, 0];
	facing			 = right;
	DoubleSpinAttack = SpinReady;
	DropdashFlag     = DashLocked;
	DrawOrder		 = depth;
	
	// Set collision radiuses
	default_radius_y = 19;
	default_radius_x = 9;
	small_radius_y   = 14;
	small_radius_x   = 7;
	radius_x = default_radius_x;
	radius_y = default_radius_y;
	
	// Set spawn position and centre the camera on us
	pos_x = x;
	pos_y = y - radius_y - 1;
	
	// Load score and lives
	Score		 = global.Score;
	Lives		 = global.Lives;
	LivesRewards = [(Rings div 100 * 100) + 100, (Score div 50000 * 50000) + 50000];
	
	// Initialise datalist
	RecordedPosX = ds_list_create();
	RecordedPosY = ds_list_create();
	
	for (var Index = 0; Index < 32; Index++) 
	{
		RecordedPosX[| Index] = x;
		RecordedPosY[| Index] = y;
	}
}