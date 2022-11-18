class DDWeapon_AssaultShotgun : DDWeapon
{
	default
	{
		Tag "Assault Shotgun";
		Inventory.Icon "DXICWP11";
		Inventory.AltHUDIcon "DXICWP12";
		DDWeapon.DropSound "DDWeapon/weapon_drop_medium";
		Inventory.PickupMessage "You found an assault shotgun";
		DDWeapon.IdleStateAmount 2;

		DDWeapon.AmmoType1 "DDAmmo_12gaBuckshot";
		DDWeapon.AmmoType2 "DDAmmo_12gaSabot";
		DDWeapon.BaseClipSize 12;

		DDWeapon.MainDamage 9;

		DDWeapon.BaseSpread 19;
		DDWeapon.BaseReloadTime 35*3;

		DDWeapon.Recoil 24;

		DDWeapon.AccurateRange 780;
		DDWeapon.MaxRange 1340;

		DDWeapon.Skill "Weapons: Rifle";
	}

	override int GetBulletAmount() { return 7; }
	override int GetPenetrationAmount() { return current_ammo_type == "DDAmmo_12gaSabot" ? 4 : 1; }

	states
	{
		Ready:
			DXAS A 0 A_StartSound("DDWeapon_AssaultShotgun/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXAS BCDEFGHI 3;
		ReadyIdle:
			DXAS A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			DXAS A 0 TryPlayIdleAnim();
			Loop;
		Idle1:
			DXAT IJKLMNOP 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXAT QRSTUVWX 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXAT CDEFGH 2;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXAS A 0 CheckClipAmmo("DryFire");
			DXAS A 0 A_StartSound("DDWeapon_AssaultShotgun/fire");
			DXAS J 2;
			DXAS K 2 Bright { HitscanAttack(); DoRecoil(); }
			DXAS L 4 Bright;
			DXAS M 4;
			Goto ReadyIdle;
		DryFire:
			DXAS A 0 A_StartSound("DDWeapon/dry_fire");
			DXAS A 6;
			Goto ReadyIdle;
		Reload:
			DXAS A 0 A_StartSound("DDWeapon_AssaultShotgun/reload");
			DXAS NOPQRST 3;
		ReloadLoop:
			DXAS UVWXY 6 AdvanceReloadTimer(6, "ReloadEnd");
		Loop;
		ReloadEnd:
			DXAS Z 2;
			DXAT AB 2;
			DXAT B 0 ReloadClip();
			DXAT B 0 A_StartSound("DDWeapon_AssaultShotgun/reload_end");
			Goto ReadyIdle;

		Spawn:
			DXAT Y -1;
			Stop;
	}
}
