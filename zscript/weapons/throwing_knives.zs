class DDWeapon_ThrowingKnives : DDWeapon
{
	default
	{
		Tag "Throwing knives";
		Inventory.Icon "DXICWP29";
		Inventory.AltHUDIcon "DXICWP30";
		DDWeapon.DropSound "DDWeapon/weapon_drop_small";
		
		DDWeapon.IdleStateAmount 2;

		DDWeapon.MainDamage 50;

		DDWeapon.BaseSpread 10;
		DDWeapon.AccurateRange 512;
		DDWeapon.MaxRange 1024;

		DDWeapon.HasSilencer true;
		DDWeapon.DenyUpgrades true;
		+Weapon.MELEEWEAPON;
		DDWeapon.UsesSelf true;
		DDWeapon.TossOne true;

		DDWeapon.Skill "Weapons: Low-Tech";
	}

	override void BeginPlay()
	{
		super.BeginPlay();
		amount = random(4, 7);
	}

	states
	{
		Ready:
			DXTK A 0 A_StartSound("DDWeapon_ThrowingKnives/select");
			DXTK BCDEFGHIJ 3;
		ReadyIdle:
			DXTK A 1 { A_WeaponReady(); return TryPlayIdleAnim(); }
			Loop;
		Idle1:
			DXTK YZ 3 A_WeaponReady();
			DXTL ABCDEF 3 A_WeaponReady();
			Goto ReadyIdle;
		Idle2:
			DXTL GHIJKLMN 3 A_WeaponReady();
			Goto ReadyIdle;

		Deselect:
			DXTK RSTUVWX 3;
			TNT0 A 0 A_Lower(999);
			Loop;
		Select:	
			TNT1 A 1 A_Raise;
			Wait;

		Fire:
			DXTK A 0 A_StartSound("DDWeapon_ThrowingKnives/fire");
			DXTK KLMNOP 3;
			DXTK Q 3;
			DXTK R 3 { ProjectileAttack("DDProjectile_ThrowingKnife", GetMainDamage()); return UseSelf("FireEnd"); }
			TNT0 A 0 A_TakeInventory("DDWeapon_ThrowingKnives", 999999);
			TNT0 A 0 A_Lower(999);
			Stop;
		FireEnd:
			DXTK A 8;
			Goto ReadyIdle;

		Spawn:
			DXTL O -1;
			Stop;
	}
}
