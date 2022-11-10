class DDProjectile_HE20mm : DDProjectile
{
	default
	{
		Radius 4;
		Height 4;

		Speed 30;
		DDProjectile.GravityZAccel 0.2;
	}

	states
	{
		Spawn:
			DXHE A 1;
			Loop;
	}

	override void DamageVictim(actor victim) {}

	override void Tick()
	{
		super.Tick();
		Spawn("DDAnimatedEffect_SmokeTrail", pos);
	}

	override void OnDeathStop()
	{
		Spawn("DDAnimatedEffect_ExplosionMedium", pos);
		Spawn("DDAnimatedEffect_EnergySphere", pos);
		DoExplosion(_damage, 128);
		A_StartSound("DDExplosion/medium2");
	}
}
