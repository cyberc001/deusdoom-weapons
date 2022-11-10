class DDProjectile_ThrowingKnife : DDProjectile
{
	default
	{
		Radius 2;
		Height 7;

		Speed 30;

		Tag "Throwing knife";
		DDProjectile.StayOnWallHit true;
		DDProjectile.CanBePickedUp true;
		DDProjectile.PickupClass "DDWeapon_ThrowingKnives";
	}

	states
	{
		Spawn:
			DXTP A 1;
			Loop;
		DeathLoop:
			DXTP B 1;
			Loop;
	}

	const spin_per_tick = 15;
	override void Tick()
	{
		super.Tick();
		if(!in_wall)
			A_SetPitch(pitch + spin_per_tick);
		else if(pitch >= -45 && pitch <= 225)
			// get "stuck in the wall" with a sharp end
			A_SetPitch(frandom(250,275));
	}

	override void OnDeathLoop() { A_StartSound("DDWeapon_ThrowingKnives/hit"); }
	override void OnDeathStop() { A_StartSound("DDWeapon_ThrowingKnives/hit"); }
}
