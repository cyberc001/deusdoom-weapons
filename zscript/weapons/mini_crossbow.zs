class DDWeapon_MiniCrossbow : DDWeapon
{
	default
	{
		Tag "Mini-crossbow";
		Inventory.Icon "DXICWP05";
		Inventory.AltHUDIcon "DXICWP06";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		DDWeapon.IdleStateAmount 2;

		DDWeapon.AmmoType1 "DDAmmo_Darts";
		DDWeapon.AmmoType2 "DDAmmo_TranquilizerDarts";
		DDWeapon.AmmoType3 "DDAmmo_FlareDarts";
		DDWeapon.BaseClipSize 4;

		DDWeapon.MainDamage 14;

		DDWeapon.BaseSpread 14;
		DDWeapon.BaseReloadTime 35*2;

		DDWeapon.Recoil 0;

		DDWeapon.Skill "Weapons: Pistol";

		DDWeapon.HasSilencer true;
	}

	Name SelectProjectile()
	{
		return current_ammo_type == "DDAmmo_Darts" ? "DDProjectile_Dart"
			: current_ammo_type == "DDAmmo_TranquilizerDarts" ? "DDProjectile_TranquilizerDart"
			: "DDProjectile_FlareDart";
	}
	override double GetDamageMult()
	{
		return current_ammo_type == "DDAmmo_Darts" ? 3 : 1;
	}


	states
	{
		Ready:
			DXCS Y 0 { if(invoker.chambered_ammo == 0) return ResolveState("ReadyEmpty"); return ResolveState(null); }
			DXCS Y 0 A_StartSound("DDWeapon_MiniCrossbow/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXCR BCDEFGHIJKLM 3;
		ReadyIdle:
			DXCT G 1 A_WeaponReady(WRF_ALLOWRELOAD);
			DXCT G 0 TryPlayIdleAnim();
			Loop;
		
		ReadyEmpty:
			DXCV Y 0 A_StartSound("DDWeapon_MiniCrossbow/select", CHAN_WEAPON, CHANF_DEFAULT, 1, ATTN_NORM, 1.65);
			DXCU BCDEFGHIJKLM 3;
		ReadyIdleEmpty:
			DXCW G 1 A_WeaponReady(WRF_ALLOWRELOAD);
			DXCW G 0 TryPlayIdleAnim();
			Loop;

		Idle1:
			DXCS Y 0 { if(invoker.chambered_ammo == 0) return ResolveState("Idle1Empty"); return ResolveState(null); }
			DXCS YZ 3 A_WeaponReady(WRF_ALLOWRELOAD);
			DXCT ABCDEF 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle1Empty:
			DXCV YZ 3 A_WeaponReady(WRF_ALLOWRELOAD);
			DXCW ABCDEF 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdleEmpty;
		Idle2:
			DXCT G 0 { if(invoker.chambered_ammo == 0) return ResolveState("Idle2Empty"); return ResolveState(null); }
			DXCT GHIJKLMNOPQR 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdle;
		Idle2Empty:
			DXCW GHIJKLMNOPQR 3 A_WeaponReady(WRF_ALLOWRELOAD);
			Goto ReadyIdleEmpty;

		Deselect:
			DXCS STUVWX 2;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXCR A 0 CheckClipAmmo("DryFire");
			DXCR A 0 A_StartSound("DDWeapon_MiniCrossbow/fire");
			DXCR N 2;
			DXCR A 0 { ProjectileAttack(invoker.SelectProjectile(), GetMainDamage()); DoRecoil(); }
			DXCR A 0 { if(invoker.chambered_ammo) return ResolveState("FireEnd"); return ResolveState("FireEndEmpty"); }
		FireEnd:
			DXCR OPQRSTUVWXYZ 2;
			DXCS ABC 2;
			Goto ReadyIdle;
		FireEndEmpty:
			DXCU PQRSTUVWXYZ 2;
			DXCV ABC 2;
			Goto ReadyIdleEmpty;
			
		DryFire:
			DXCU N 0 A_StartSound("DDWeapon/dry_fire");
			DXCU N 6;
			Goto ReadyIdleEmpty;
		Reload:
			DXCS A 0 A_StartSound("DDWeapon_MiniCrossbow/reload");
			DXCS DEFG 3;
		ReloadLoop:
			DXCS HIJKLMN 5 AdvanceReloadTimer(5, "ReloadEnd");
			Loop;
		ReloadEnd:
			DXCS OPQR 2;
			DXCS A 0 ReloadClip();
			DXCS A 0 A_StartSound("DDWeapon_MiniCrossbow/reload_end");
			Goto ReadyIdle;

		Spawn:
			DXCT S -1;
			Stop;
	}
}

