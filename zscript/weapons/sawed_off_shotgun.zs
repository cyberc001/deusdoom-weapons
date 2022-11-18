class DDWeapon_SawedOffShotgun : DDWeapon
{
	default
	{
		Tag "Sawed-off Shotgun";
		Inventory.Icon "DXICWP13";
		Inventory.AltHUDIcon "DXICWP14";
		DDWeapon.DropSound "DDWeapon/weapon_drop_medium";
		DDWeapon.IdleStateAmount 2;

		DDWeapon.AmmoType1 "DDAmmo_12gaBuckshot";
		DDWeapon.AmmoType2 "DDAmmo_12gaSabot";
		DDWeapon.BaseClipSize 4;

		DDWeapon.MainDamage 10;

		DDWeapon.BaseSpread 17;
		DDWeapon.BaseReloadTime 35*3;

		DDWeapon.Recoil 17;

		DDWeapon.AccurateRange 780;
		DDWeapon.MaxRange 1340;

		DDWeapon.Skill "Weapons: Rifle";
	}

	override int GetBulletAmount() { return 8; }
	override int GetPenetrationAmount() { return current_ammo_type == "DDAmmo_12gaSabot" ? 4 : 1; }

	states
	{
		Ready:
			DXSS A 0 A_StartSound("DDWeapon_SawedOffShotgun/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXSS BCDEFGHIJKLM 3;
		ReadyIdle:
			DXSS A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			DXSS A 0 TryPlayIdleAnim();
			Loop;
		Idle1:
			DXST YZ 3 A_WeaponReady(WRF_ALLOWRELOAD);
			DXSU ABCDEF 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXSU GHIJKLMN 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXST STUVWX 2;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXSS A 0 CheckClipAmmo("DryFire");
			DXSS A 0 A_StartSound("DDWeapon_SawedOffShotgun/fire");
			DXSS NO 2;
			DXSS P 2 Bright { HitscanAttack(); DoRecoil(); }
			DXSS Q 2 Bright;
			DXSS RSTUVWXYZ 2;
			DXST AB 2;
			Goto ReadyIdle;
		DryFire:
			DXSS A 0 A_StartSound("DDWeapon/dry_fire");
			DXSS A 6;
			Goto ReadyIdle;
		Reload:
			DXST C 0 A_StartSound("DDWeapon_SawedOffShotgun/reload");
			DXST CDEFG 3;
		ReloadLoop:
			DXST HIJKLMN 6 AdvanceReloadTimer(6, "ReloadEnd");
		Loop;
		ReloadEnd:
			DXST OPQR 2;
			DXST R 0 ReloadClip();
			DXST R 0 A_StartSound("DDWeapon_SawedOffShotgun/reload_end");
			Goto ReadyIdle;

		Spawn:
			DXSU O -1;
			Stop;
	}
}
