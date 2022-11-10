class DDAnimatedEffect_Steam : DDAnimatedEffect
{
	default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;

		DDAnimatedEffect.ScaleStart 1.5;
		DDAnimatedEffect.ScaleEnd 1.9;
		DDAnimatedEffect.AlphaStart 4.0;
		DDAnimatedEffect.AlphaEnd 0.1;
		DDAnimatedEffect.AnimDuration 2*14*4;
	}

	states
	{
		Spawn:
			DDST ABCDEFGHIJKLMN 2;
			DDST ABCDEFGHIJKLMN 2;
			DDST ABCDEFGHIJKLMN 2;
			DDST ABCDEFGHIJKLMN 2;
			Stop;
	}
}
