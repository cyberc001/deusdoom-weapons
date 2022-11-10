class DDAnimatedEffect_EnergySphere : DDAnimatedEffect
{
	default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;

		DDAnimatedEffect.ScaleStart 0.05;
		DDAnimatedEffect.ScaleEnd 1.25;
		DDAnimatedEffect.AlphaStart 0.65;
		DDAnimatedEffect.AlphaEnd 0.2;
		DDAnimatedEffect.AnimDuration 15;
	}

	states
	{
		Spawn:
			DXES A 15;
			Stop;
	}
}

class DDAnimatedEffect_EnergySphereLarge : DDAnimatedEffect_EnergySphere
{
	default
	{
		DDAnimatedEffect.ScaleEnd 2.5;
		DDAnimatedEffect.AnimDuration 21;
	}

	states
	{
		Spawn:
			DXES A 21;
			Stop;
	}
}
