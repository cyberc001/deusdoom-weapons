class DDProjectile_RocketLAW : DDProjectile
{
	default
	{
		Radius 4;
		Height 4;

		Speed 30;
		DDProjectile.GravityZAccel 0.01;
	}

	states
	{
		Spawn:
			DXRL A 1;
			Loop;
	}

	override void DamageVictim(actor victim) {}

	const idle_sound_delay = 35;
	int idle_sound_timer;
	override void Tick()
	{
		super.Tick();
		Spawn("DDAnimatedEffect_SmokeTrail", pos);
		if(idle_sound_timer > 0)
			--idle_sound_timer;
		else{
			A_StartSound("DDProjectile_RocketLAW/idle");
			idle_sound_timer = idle_sound_delay;
		}
	}

	override void OnDeathStop()
	{
		Spawn("DDAnimatedEffect_ExplosionLarge", pos);
		Spawn("DDAnimatedEffect_EnergySphereLarge", pos);
		DoExplosion(_damage, 260);
		A_StartSound("DDExplosion/large1", CHAN_AUTO, CHANF_DEFAULT, 1, ATTN_NORM, 1);
	}
}
