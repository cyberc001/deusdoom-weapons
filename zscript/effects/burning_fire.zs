class DDEffect_BurningFire : Actor
{
	default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;
		+BRIGHT;

		RenderStyle "Translucent";
		Alpha 0.6;
	}

	states
	{
		Spawn:
			DDBF ABCDEFGHIJKLMNOPQRSTUVWXYZ 1;
			DDBG ABCDEFGHI 1;
			Loop;
	}


	vector3 warp_off;
	override void Tick()
	{
		super.Tick();

		if(target)
			warp(target, warp_off.x, warp_off.y, warp_off.z, 0, WARPF_COPYVELOCITY | WARPF_INTERPOLATE);
	}
}
