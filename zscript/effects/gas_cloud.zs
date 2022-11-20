class DDAnimatedEffect_GasCloud : DDAnimatedEffect
{
	default
	{
		+NOBLOCKMAP;

		DDAnimatedEffect.ScaleStart 1.25;
		DDAnimatedEffect.ScaleEnd 2.5;
		DDAnimatedEffect.AlphaStart 1.0;
		DDAnimatedEffect.AlphaEnd 1.0;
		DDAnimatedEffect.AnimDuration 35*4;
	}

	states
	{
		Spawn:
			DDGC ABCDEFGHIJKLMNOP 4;
			Loop;
	}

	int roam_timer;
	const roam_time_min = 55;
	const roam_time_max = 105;
	const roam_vel_min = 0.85;
	const roam_vel_max = 1.45;

	int lifetime;
	double fadeout_alpha;

	const stun_radius = 105;

	override void BeginPlay()
	{
		super.BeginPlay();
		lifetime = 35*30;
		fadeout_alpha = 1.0;
	}

	override void Tick()
	{
		super.Tick();

		// randomly move around
		if(roam_timer > 0)
			--roam_timer;
		else{
			A_ChangeVelocity(frandom(roam_vel_min, roam_vel_max) * (random(0, 1) ? 1 : -1),
							frandom(roam_vel_min, roam_vel_max) * (random(0, 1) ? 1 : -1),
							0);
			roam_timer = random(roam_time_min, roam_time_max);
		}

		// stun monsters
		BlockThingsIterator itb = BlockThingsIterator.Create(self, stun_radius);
		while(itb.next()){
			Actor victim = itb.thing;
			if(victim == self || (!victim.bISMONSTER && !victim.player) || !CheckSight(victim))
				continue;

			if(victim.player){
				let existing_poison = victim.FindInventory("DDPowerup_PlayerGasPoison");
				if(!existing_poison){
					let poison = Inventory(Actor.Spawn("DDPowerup_PlayerGasPoison"));
					victim.addInventory(poison);
				}
			}
			else{
				let existing_stun = victim.FindInventory("DDPowerup_GasStun");
				if(!existing_stun){
					let stun = Inventory(Actor.Spawn("DDPowerup_GasStun"));
					victim.addInventory(stun);
				}
			}
		}

		// fade out if expired
		if(lifetime > 0)
			--lifetime;
		else{
			if(fadeout_alpha > 0){
				fadeout_alpha -= 0.015;
				A_SetRenderStyle(fadeout_alpha, STYLE_Translucent);
			}
			else
				Destroy();
		}
	}
}
