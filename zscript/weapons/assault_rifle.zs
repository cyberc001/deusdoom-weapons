class DDWeapon_AssaultRifle : DDWeapon
{
	default
	{
		Tag "Assault Rifle";
		Inventory.Icon "DXICWP09";
		Inventory.AltHUDIcon "DXICWP10";
		DDWeapon.DropSound "DDWeapon/weapon_drop_medium";
		DDWeapon.IdleStateAmount 2;

		DDWeapon.AmmoType1 "DDAmmo_7_62mm";
		DDWeapon.AmmoType2 "DDAmmo_HE20mm";
		DDWeapon.BaseClipSize 30;
		DDweapon.BaseClipSize2 1;

		DDWeapon.MainDamage 12;

		DDWeapon.BaseSpread 16;
		DDWeapon.BaseReloadTime 35*3;

		DDWeapon.Recoil 8;

		DDWeapon.Skill "Weapons: Rifle";

		DDWeapon.CanInstallSilencer true;
	}

	override double GetDamageMult()
	{
		return current_ammo_type == "DDAmmo_HE20mm" ? 16.6 : 1;
	}
	override int GetBonusClipPerUpgrade() { return 3; }

	states
	{
		Ready:
			DXAG A 0 A_StartSound("DDWeapon_AssaultRifle/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXAG BCDEFGHI 3;
		ReadyIdle:
			DXAG A 1 A_WeaponReady(WRF_ALLOWRELOAD);
			DXAG A 0 TryPlayIdleAnim();
			Loop;
		Idle1:
			DXAH LMNOPQRS 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2:
			DXAH TUVWXYZ 3 A_WeaponReady(WRF_ALLOWRELOAD);
			DXAI A 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;

		Deselect:
			DXAH GHIJK 2;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXAG A 0 CheckClipAmmo("DryFire");
			DXAG A 0 { if(invoker.AmmoType1 == "DDAmmo_HE20mm") return ResolveState("FireGrenade"); return ResolveState(null); }
			DXAG A 0 A_StartSound("DDWeapon_AssaultRifle/fire");
			DXAG JK 2;
			DXAG L 2 { HitscanAttack(GetMainDamage()); DoRecoil(0.33); }
			DXAG M 2; 
			DXAG N 2 { HitscanAttack(GetMainDamage()); DoRecoil(0.33); }
			DXAG O 2; 
			DXAG P 2 { HitscanAttack(GetMainDamage()); DoRecoil(0.33); }
			DXAG Q 2;
			DXAG A 2;
			Goto ReadyIdle;
		FireGrenade:
			DXAG A 0 A_StartSound("DDWeapon_AssaultRifle/fire_grenade");
			DXAI B 2 { ProjectileAttack("DDProjectile_HE20mm", GetMainDamage()); DoRecoil(); }
			DXAI B 8;
			Goto ReadyIdle;
		DryFire:
			DXAG A 0 A_StartSound("DDWeapon/dry_fire");
			DXAI B 6;
			Goto ReadyIdle;
		Reload:
			DXAG A 0 A_StartSound("DDWeapon_AssaultRifle/reload");
			DXAG RSTUV 3;
		ReloadLoop:
			DXAG WXYZ 6 AdvanceReloadTimer(6, "ReloadEnd");
			DXAH ABC 6 AdvanceReloadTimer(6, "ReloadEnd");
		Loop;
		ReloadEnd:
			DXAH DEF 2;
			DXAH F 0 ReloadClip();
			DXAH F 0 A_StartSound("DDWeapon_AssaultRifle/reload_end");
			Goto ReadyIdle;

		Spawn:
			DXAI C -1;
			Stop;
	}
}

