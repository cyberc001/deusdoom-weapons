class DDWeapon_GEPGun : DDWeapon
{
	default
	{
		Tag "GEP Gun";
		Inventory.Icon "DXICWP47";
		Inventory.AltHUDIcon "DXICWP48";
		DDWeapon.DropSound "DDWeapon/weapon_drop_large";
		DDWeapon.IdleStateAmount 2;
		Inventory.PickupMessage "You found a GEP gun";

		DDWeapon.AmmoType1 "DDAmmo_Rockets";
		DDWeapon.AmmoType2 "DDAmmo_WPRockets";
		DDWeapon.BaseClipSize 1;

		DDWeapon.MainDamage 260;

		DDWeapon.BaseSpread 16;
		DDWeapon.BaseReloadTime 35*2;

		DDWeapon.Recoil 18;

		DDWeapon.HasLockOn true;
		DDWeapon.MaxBonusClip 0;

		DDWeapon.Skill "Weapons: Heavy";
	}

	override double GetDamageMult()
	{
		return current_ammo_type == "DDAmmo_Rockets" ? 1 : 0.2;
	}

	states
	{
		Ready:
			DXGG A 0 A_StartSound("DDWeapon_GEPGun/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXGG BCDEFGHIJK 5;
		ReadyIdle:
			DXGG A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			DXGG A 0 TryPlayIdleAnim();
			Loop;
		Idle1:
			DXGH PQRSTUVW 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXGH XYZ 3 A_WeaponReady(WRF_ALLOWRELOAD);
			DXGI ABCDE 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXGG QRSTUVWXYZ 4;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXGG A 0 CheckClipAmmo("DryFire");
			DXGG A 0 A_StartSound(invoker.current_ammo_type == "DDAmmo_Rockets" ? "DDWeapon_GEPGun/fire" : "DDWeapon_GEPGun/fire_wp");
			DXGG LM 2;
			DXGG N 2 {
						DDProjectile_RocketGEPGun proj;
						if(invoker.current_ammo_type == "DDAmmo_Rockets")
							proj = DDProjectile_RocketGEPGun(ProjectileAttack("DDProjectile_RocketGEPGun", GetMainDamage()));
						else
							proj = DDProjectile_WPRocketGEPGun(ProjectileAttack("DDProjectile_WPRocketGEPGun", GetMainDamage()));
						if(invoker.IsLockedOn()) proj.lock_on = invoker.last_valid_target;
						DoRecoil();
					}
			DXGG OP 2;
			DXGG P 4;
			Goto ReadyIdle;
		DryFire:
			DXGG A 0 A_StartSound("DDWeapon/dry_fire");
			DXGG A 6;
			Goto ReadyIdle;
		Reload:
			DXGG A 0 A_StartSound("DDWeapon_GEPGun/reload");
			DXGH ABCDE 3;
		ReloadLoop:
			DXGH FGHIJK 6 AdvanceReloadTimer(6, "ReloadEnd");
		Loop;
		ReloadEnd:
			DXGH LMNO 2;
			DXGH O 0 ReloadClip();
			Goto ReadyIdle;

		Spawn:
			DXGI F -1;
			Stop;
	}
}

