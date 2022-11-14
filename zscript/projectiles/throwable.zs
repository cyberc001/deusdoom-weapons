class DDThrowableProjectile : DDProjectile
{
	default
	{
		Radius 4;
		Height 4;

		Speed 20;
		DDProjectile.GravityZAccel 0.45;
		DDProjectile.StayOnWallHit true;
		DDProjectile.StayOnActorHit true;

		BounceType "Doom";
		BounceFactor 0.6;
		DDProjectile.FallFlat true;
		BounceSound "DDThrowableProjectile/bounce";

		DDProjectile.ExplosionTimer 35*3;
		DDThrowableProjectile.BeepSound "DDThrowableProjectile/beep";

		DDThrowableProjectile.BeepDelayStart 25;
		DDThrowableProjectile.BeepDelayMul 0.75;
		DDThrowableProjectile.BeepDelayMin 3;
	}

	override void DamageVictim(Actor victim){}

	string beep_sound;
	property BeepSound: beep_sound;
	int beep_delay;
	int beep_delay_start;
	property BeepDelayStart: beep_delay_start;
	double beep_delay_mul;
	property BeepDelayMul: beep_delay_mul;
	int beep_delay_min;
	property BeepDelayMin: beep_delay_min;
	int beep_timer;

	override void BeginPlay()
	{
		super.BeginPlay();
		beep_delay = beep_delay_start;
		beep_timer = beep_delay;
	}

	override void Tick()
	{
		super.Tick();
		if(sqrt(vel.x**2 + vel.y**2) <= 0.5)
			BounceSound = "";

		--beep_timer;
		if(beep_timer <= 0){
			beep_delay *= beep_delay_mul;
			if(beep_delay < beep_delay_min)
				beep_delay = beep_delay_min;
			beep_timer = beep_delay;
			A_StartSound(beep_sound);
		}
	}


	action State PlayFlashingAnim(StateLabel flash_st = "Flash")
	{
		if(invoker.beep_timer <= 1)
			return ResolveState(flash_st);
		return ResolveState(null);
	}

	void DoEMPAoe(int _radius, double mul)
	{
		BlockThingsIterator itb = BlockThingsIterator.Create(self, _radius);
		while(itb.next()){
			Actor victim = itb.thing;
			if((victim == self || !victim.bISMONSTER || !CheckSight(victim)) && !victim.player)
				continue;

			if(victim.player){
				double dist = (Distance3D(victim) - victim.radius) / _radius;
				dist = dist > 1 ? 1 : dist < 0 ? 0 : dist;
				int bioel_taken = 20 + 65 * (1 - dist);
				Name bioel = "DD_BioelectricEnergy";
				if(bioel)
					victim.TakeInventory(bioel, bioel_taken);
			}
			else{
				double dist = (Distance3D(victim) - victim.radius) / _radius;
				dist = dist > 1 ? 1 : dist < 0 ? 0 : dist;
				let existing_stun = DDPowerup_EMPStun(victim.FindInventory("DDPowerup_EMPStun"));
				if(existing_stun && existing_stun.dur_coff < (0.5 + 0.5 * (1 - dist)) * mul){
					existing_stun.DetachFromOwner();
					existing_stun.Destroy();
				}
				let stun = DDPowerup_EMPStun(Actor.Spawn("DDPowerup_EMPStun"));
				stun.dur_coff = (0.5 + 0.5 * (1 - dist)) * mul;
				victim.addInventory(stun);
			}
		}
	}

	void DoScrambleAOE(int _radius, double mul)
	{
		BlockThingsIterator itb = BlockThingsIterator.Create(self, _radius);
		while(itb.next()){
			Actor victim = itb.thing;
			if(victim == self || !CheckSight(victim) || !victim.bISMONSTER)
				continue;

			double dist = (Distance3D(victim) - victim.radius) / _radius;
			dist = dist > 1 ? 1 : dist < 0 ? 0 : dist;
			let existing_scr = DDPowerup_Scramble(victim.FindInventory("DDPowerup_Scramble"));
			if(existing_scr && existing_scr.dur_coff < (0.5 + 0.5 * (1 - dist)) * mul){
				victim.bFRIENDLY = !victim.bFRIENDLY;
				existing_scr.DetachFromOwner();
				existing_scr.Destroy();
			}
			let scr = DDPowerup_Scramble(Actor.Spawn("DDPowerup_Scramble"));
			scr.dur_coff = (0.5 + 0.5 * (1 - dist)) * mul;
			victim.addInventory(scr);
			victim.target = null;
		}
	}
}
