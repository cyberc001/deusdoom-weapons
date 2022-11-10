class DDProjectile_GasGrenade : DDThrowableProjectile
{
	states
	{
		Spawn:
			DXGP A 1 CheckFallFlat();
			Loop;
		FallFlat: // have to offset the model by z-8 so it doesn't clip into the ground
			DXGP B 1;
			Loop;
	}

	override void ExplodeOnTimer()
	{
		Spawn("DDAnimatedEffect_EnergySphere", pos);
		double mul = (_damage / 1000.) * 2;
		uint cloud_cnt = 12 * mul;
		double spread = 120 * (_damage / 1000.) * 1.6;
		SpawnSpreadActors("DDAnimatedEffect_GasCloud", null, cloud_cnt, spread, spread);
		Spawn("DDAnimatedEffect_ExplosionMediumLAM", pos);
		A_StartSound("DDWeapon_GasGrenade/explode");
		Destroy();
	}
}

class DDProjectile_PlacedGasGrenade : DDPlaceableProjectile
{
	default
	{
		Radius 1;
		Height 1;
		DDProjectile.CanBePickedUp true;
		DDProjectile.PickupClass "DDWeapon_GasGrenade";

		Tag "Gas grenade";
	}

	states
	{
		Spawn:
			DXGP A 1;
			Loop;
	}

	override void ExplodeOnTimer()
	{
		Spawn("DDAnimatedEffect_EnergySphere", pos);
		double mul = (_damage / 1000.) * 2;
		uint cloud_cnt = 12 * mul;
		double spread = 120 * (_damage / 1000.) * 1.6;
		SpawnSpreadActors("DDAnimatedEffect_GasCloud", null, cloud_cnt, spread, spread);
		Spawn("DDAnimatedEffect_ExplosionMediumLAM", pos);
		A_StartSound("DDWeapon_GasGrenade/explode");
		Destroy();
	}
}
