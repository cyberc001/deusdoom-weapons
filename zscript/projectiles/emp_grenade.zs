class DDProjectile_EMPGrenade : DDThrowableProjectile
{
	states
	{
		Spawn:
			DXEP ABCDEFGHIJKLMNOPQRSTU 1 CheckFallFlat();
			Loop;
		FallFlat: // have to offset the model by z-8 so it doesn't clip into the ground
			DXEQ ABCDEFGHIJKLMNOPQRSTU 1;
			Loop;
	}

	override void ExplodeOnTimer()
	{
		Spawn("DDAnimatedEffect_EMPSphere", pos);
		Spawn("DDAnimatedEffect_ExplosionMediumLAM", pos);
		DoEMPAoe(320, (_damage / 1000.) * 1.25);
		A_StartSound("DDWeapon_EMPGrenade/explode");
		Destroy();
	}
}

class DDProjectile_PlacedEMPGrenade : DDPlaceableProjectile
{
	default
	{
		Radius 1;
		Height 1;
		DDProjectile.CanBePickedUp true;
		DDProjectile.PickupClass "DDWeapon_EMPGrenade";

		Tag "EMP grenade";
	}

	states
	{
		Spawn:
			DXEP ABCDEFGHIJKLMNOPQRSTU 1;
			Loop;
	}

	override void ExplodeOnTimer()
	{
		Spawn("DDAnimatedEffect_EMPSphere", pos);
		Spawn("DDAnimatedEffect_ExplosionMediumLAM", pos);
		DoEMPAoe(320, (_damage / 1000.) * 1.25);
		A_StartSound("DDWeapon_EMPGrenade/explode");
		Destroy();
	}
}
