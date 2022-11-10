class DDProjectile_ScrambleGrenade : DDThrowableProjectile
{
	states
	{
		Spawn:
			DXSP ABCDEFGHIJKLMNO 1 Bright CheckFallFlat();
			Loop;
		FallFlat: // have to offset the model by z-8 so it doesn't clip into the ground
			DXSQ ABCDEFGHIJKLMNO 1 Bright;
			Loop;
	}

	override void ExplodeOnTimer()
	{
		Spawn("DDAnimatedEffect_EMPSphere", pos);
		Spawn("DDAnimatedEffect_ExplosionMediumLAM", pos);
		DoScrambleAoe(320, _damage / 1000.);
		A_StartSound("DDWeapon_ScrambleGrenade/explode");
		Destroy();
	}
}

class DDProjectile_PlacedScrambleGrenade : DDPlaceableProjectile
{
	default
	{
		Radius 1;
		Height 1;
		DDProjectile.CanBePickedUp true;
		DDProjectile.PickupClass "DDWeapon_ScrambleGrenade";

		Tag "Scramble grenade";
	}

	states
	{
		Spawn:
			DXSP ABCDEFGHIJKLMNO 1 Bright;
			Loop;
	}

	override void ExplodeOnTimer()
	{
		Spawn("DDAnimatedEffect_EMPSphere", pos);
		Spawn("DDAnimatedEffect_ExplosionMediumLAM", pos);
		DoScrambleAoe(320, _damage / 1000.);
		A_StartSound("DDWeapon_ScrambleGrenade/explode");
		Destroy();
	}
}
