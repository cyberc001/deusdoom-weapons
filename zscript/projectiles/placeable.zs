class DDPlaceableProjectile : DDThrowableProjectile
{
	default
	{
		-NOBLOCKMAP;

		Speed 0;
		DDProjectile.GravityZAccel 0;
		BounceType "None";
		DDProjectile.FallFlat false;
		
		DDProjectile.ExplosionTimer 35*2;
		DDPlaceableProjectile.ArmTime 35*2;
		DDPlaceableProjectile.ProximityRange 75;

		DDThrowableProjectile.BeepDelayStart 15;
		DDThrowableProjectile.BeepDelayMul 0.6;
		DDThrowableProjectile.BeepDelayMin 3;
	}

	const stop_beep_time = 20;
	int stop_beep_timer;
	string prev_beep_sound;

	int arm_time;
	property ArmTime: arm_time;
	double proximity_range;
	property ProximityRange: proximity_range;
	bool exploding;

	override void BeginPlay()
	{
		super.BeginPlay();
		stop_beep_timer = -1;
		prev_beep_sound = beep_sound;
	}

	override void Tick()
	{
		super.Tick();

		// Stop beeping after being placed for a while
		if(stop_beep_timer > 0)
			--stop_beep_timer;
		else if(stop_beep_timer == 0){
			beep_sound = "";
			stop_beep_timer = -2;
		}
		if(beep_delay == beep_delay_min && stop_beep_timer == -1)
			stop_beep_timer = stop_beep_time;

		if(stop_beep_timer <= 0 && arm_time > 0){
			--arm_time;
			++explosion_timer;
		}
		else if(arm_time <= 0 && !exploding)
			++explosion_timer;

		if(arm_time <= 0 && !exploding){ // armed, look for someone in proximity
			BlockThingsIterator bti = BlockThingsIterator.create(self, proximity_range);
			while(bti.next()){
				Actor a = bti.thing;
				if(a.bISMONSTER && a.Health > 0 && a != target && !a.bFRIENDLY && CheckSight(a)){
					exploding = true;
					beep_sound = prev_beep_sound;
					beep_delay = beep_delay_start;
					beep_timer = beep_delay;
					break;
				}
			}
		}
	}
}
