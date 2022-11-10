class DDProjectile_PlasmaBolt : DDProjectile
{
	default
	{
		Radius 6;
		Height 6;

		Speed 20;

		RenderStyle "Translucent";
		Alpha 0.75;
		+BRIGHT;

		DDProjectile.GravityZAccel 0.1;
	}

	states
	{
		Spawn:
			DXPB B 1;
			Loop;
	}

	override void OnDeathStop()
	{
		Spawn("DDEffect_PlasmaSmoke", pos);
		DoExplosion(_damage, 48);
		A_StartSound("DDProjectile_PlasmaBolt/hit");
	}
}
