class DDAnimatedEffect_SmokeTrail : DDAnimatedEffect
{
	default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;

		DDAnimatedEffect.ScaleStart 0.2;
		DDAnimatedEffect.ScaleEnd 0.8;
		DDAnimatedEffect.AlphaStart 0.85;
		DDAnimatedEffect.AlphaEnd 0.6;
		DDAnimatedEffect.AnimDuration 14*2;
	}

	states
	{
		Spawn:
			DDST ABCDEFGHIJKLMN 2;
			Stop;
	}
}
