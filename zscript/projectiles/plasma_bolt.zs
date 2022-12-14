class DDProjectile_PlasmaBolt : DDProjectile
{
	default
	{
		Radius 6;
		Height 6;

		Speed 45;

		RenderStyle "Translucent";
		Alpha 0.75;
		+BRIGHT;

		DDProjectile.GravityZAccel 0.06;
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
		DoExplosion(_damage, 80);
		A_StartSound("DDProjectile_PlasmaBolt/hit");
		A_SprayDecal(random(0, 1) ? "DDDecal_PlasmaScorch1" : "DDDecal_PlasmaScorch2");
	}
}
