class DDAnimatedEffect_EMPSphere : DDAnimatedEffect
{
	default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;

		DDAnimatedEffect.ScaleStart 0.05;
		DDAnimatedEffect.ScaleEnd 1.5;
		DDAnimatedEffect.AlphaStart 0.75;
		DDAnimatedEffect.AlphaEnd 0.3;
		DDAnimatedEffect.AnimDuration 20;
	}

	states
	{
		Spawn:
			DXES A 20;
			Stop;
	}
}
