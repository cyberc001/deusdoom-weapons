class DDAnimatedEffect_TearGas : DDAnimatedEffect
{
	default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;

		DDAnimatedEffect.ScaleStart 0.2;
		DDAnimatedEffect.ScaleEnd 0.2;
		DDAnimatedEffect.AlphaStart 0.6;
		DDAnimatedEffect.AlphaEnd 0;
		DDAnimatedEffect.AnimDuration 10;
	}

	states
	{
		Spawn:
			DDTG A 10;
			Stop;
	}

	vector3 warp_off;
	vector3 dir;
	override void Tick()
	{
		Warp(target, warp_off.x, warp_off.y, warp_off.z, 0, WARPF_ABSOLUTEOFFSET | WARPF_ABSOLUTEANGLE | WARPF_INTERPOLATE);
		warp_off += dir * 3;
		super.Tick();
	}
}
