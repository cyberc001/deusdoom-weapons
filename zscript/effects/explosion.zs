class DDAnimatedEffect_ExplosionMedium : DDAnimatedEffect
{
	default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;
		+BRIGHT;

		DDAnimatedEffect.ScaleStart 0.7;
		DDAnimatedEffect.ScaleEnd 1.2;
		DDAnimatedEffect.AlphaStart 0.9;
		DDAnimatedEffect.AlphaEnd 0.2;
		DDAnimatedEffect.AnimDuration 8*3;
	}

	states
	{
		Spawn:
			DDEX KLMNOPQR 3;
			Stop;
	}
}

class DDAnimatedEffect_ExplosionLarge : DDAnimatedEffect_ExplosionMedium
{
	default
	{
		DDAnimatedEffect.ScaleEnd 1.75;
	}
}

class DDAnimatedEffect_ExplosionMediumLAM : DDAnimatedEffect
{
	default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;
		+BRIGHT;

		DDAnimatedEffect.ScaleStart 0.7;
		DDAnimatedEffect.ScaleEnd 1.0;
		DDAnimatedEffect.AlphaStart 0.5;
		DDAnimatedEffect.AlphaEnd 0.2;
		DDAnimatedEffect.AnimDuration 8*3;
	}

	states
	{
		Spawn:
			DDEX K 0 {
				switch(random(0, 2)){
					case 0: return ResolveState("Spawn1");
					case 1: return ResolveState("Spawn2");
					case 2: return ResolveState("Spawn3");
				}
				return ResolveState(null);
			}
		Spawn1:
			DDEX KLMNOPQR 3;
			Stop;
		Spawn2:
			DDEX LMNOPQR 3;
			Stop;
		Spawn3:
			DDEX MNOPQR 3;
			Stop;
	}
}
