class DDProjectile_Dart : DDProjectile
{
	default
	{
		Radius 3;
		Height 2;

		Speed 45;

		Tag "Dart";
		DDProjectile.StayOnWallHit true;
		DDProjectile.CanBePickedUp true;
		DDProjectile.PickupClass "DDAmmo_Darts";
	}

	states
	{
		Spawn:
			DXDT A 1;
			Loop;
	}

	override void OnDeathLoop(){ A_StartSound("DDWeapon_ThrowingKnives/hit"); }
	override void OnDeathStop(){ A_StartSound("DDWeapon_ThrowingKnives/hit"); }
}
class DDProjectile_TranquilizerDart : DDProjectile_Dart
{
	default
	{
		DDProjectile.PickupClass "DDAmmo_TranquilizerDarts";
		Tag "Tranquilizer dart";
	}

	override void DamageVictim(Actor victim)
	{
		super.DamageVictim(victim);
		if(!victim.countInv("DDPowerup_TranqPoison")){
			let pois = DDPowerup_TranqPoison(Inventory.Spawn("DDPowerup_TranqPoison"));
			pois.dmg = _damage * 0.75;
			victim.addInventory(pois);
		}
	}
}
class DDProjectile_FlareDart : DDProjectile_Dart
{
	default
	{
		DDProjectile.PickupClass "DDAmmo_FlareDarts";
		Tag "Flare dart";
	}
}
