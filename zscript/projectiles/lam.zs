class DDProjectile_LAM : DDThrowableProjectile
{
	states
	{
		Spawn:
			DXLP A 1 CheckFallFlat();
			DXLP A 0 PlayFlashingAnim();
			Loop;
		Flash:
			DXLP C 1 Bright CheckFallFlat();
			Goto Spawn;
		FallFlat: // have to offset the model by z-8 so it doesn't clip into the ground
			DXLP B 1 PlayFlashingAnim("FlashFallFlat");
			Loop;
		FlashFallFlat:
			DXLP D 1 Bright;
			Goto FallFlat;
	}

	override void ExplodeOnTimer()
	{
		Spawn("DDAnimatedEffect_EnergySphere", pos);
		Spawn("DDAnimatedEffect_ExplosionMediumLAM", pos);
		SpawnSpreadActors("DDAnimatedEffect_Steam");
		DoExplosion(_damage, 264);
		A_StartSound("DDWeapon_LAM/explode");
		Destroy();
	}
}

class DDProjectile_PlacedLAM : DDPlaceableProjectile
{
	default
	{
		Radius 1;
		Height 1;
		DDProjectile.CanBePickedUp true;
		DDProjectile.PickupClass "DDWeapon_LAM";

		Tag "LAM";
	}

	states
	{
		Spawn:
			DXLP A 1 PlayFlashingAnim();
			Loop;
		Flash:
			DXLP C 1 Bright;
			Goto Spawn;
	}

	override void ExplodeOnTimer()
	{
		Spawn("DDAnimatedEffect_EnergySphere", pos);
		Spawn("DDAnimatedEffect_ExplosionMediumLAM", pos);
		SpawnSpreadActors("DDAnimatedEffect_Steam");
		DoExplosion(_damage, 264);
		A_StartSound("DDWeapon_LAM/explode");
		Destroy();
	}
}
