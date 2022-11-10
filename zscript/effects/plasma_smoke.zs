class DDEffect_PlasmaSmoke : Actor
{
	default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;
		+BRIGHT;

		Scale 0.4;
	}

	states
	{
		Spawn:
			DDSM ABCDEFGHIJK 3;
			Stop;
	}
}
