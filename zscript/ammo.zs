class DDAmmo_10mm : Ammo
{
	default
	{
		Inventory.Amount 8;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 150;
		Ammo.BackpackMaxAmount 300;
		+THRUACTORS; // so it won't be picked up right at BeginPlay(), before InventoryWrapper has a chance to spawn
		Inventory.Icon "DXUIWP02"; // so the engine doesn't display stray sprites
		Inventory.AltHUDIcon "DXUIWP02";

		Tag "10mm Ammo";
		Inventory.PickupMessage "You found 10mm ammo";
	}
	states
	{
		Spawn:
			DDAM A 1;
			Loop;
	}
}

class DDAmmo_Darts : Ammo
{
	default
	{
		Inventory.Amount 4;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 60;
		Ammo.BackpackMaxAmount 120;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";

		Tag "Darts";
		Inventory.PickupMessage "You found darts";
	}
	states
	{
		Spawn:
			DDAM B 1;
			Loop;
	}
}
class DDAmmo_TranquilizerDarts : Ammo
{
	default
	{
		Inventory.Amount 4;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 60;
		Ammo.BackpackMaxAmount 120;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";

		Tag "Tranq. darts";
		Inventory.PickupMessage "You found tranquilizer darts";
	}
	states
	{
		Spawn:
			DDAM C 1;
			Loop;
	}
}
class DDAmmo_FlareDarts : Ammo
{
	default
	{
		Inventory.Amount 8;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 60;
		Ammo.BackpackMaxAmount 120;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";

		Tag "Flare darts";
		Inventory.PickupMessage "You found flare darts";
	}
	states
	{
		Spawn:
			DDAM D 1;
			Loop;
	}
}

class DDAmmo_7_62mm : Ammo
{
	default
	{
		Inventory.Amount 30;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 400;
		Ammo.BackpackMaxAmount 800;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";
		Inventory.PickupMessage "You found 7.62mm ammo";

		Tag "7.62x51mm";
	}
	states
	{
		Spawn:
			DDAM E 1;
			Loop;
	}
}
class DDAmmo_HE20mm : Ammo
{
	default
	{
		Inventory.Amount 4;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 30;
		Ammo.BackpackMaxAmount 60;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";

		Tag "20mm HE";
		Inventory.PickupMessage "You found 20mm HE grenades";
	}
	states
	{
		Spawn:
			DDAM F 1;
			Loop;
	}
}


class DDAmmo_12gaBuckshot : Ammo
{
	default
	{
		Inventory.Amount 6;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 96;
		Ammo.BackpackMaxAmount 192;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";

		Tag "Buckshot shells";
		Inventory.PickupMessage "You found 12ga buckshot shells";
	}
	states
	{
		Spawn:
			DDAM G 1;
			Loop;
	}
}
class DDAmmo_12gaSabot : Ammo
{
	default
	{
		Inventory.Amount 6;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 96;
		Ammo.BackpackMaxAmount 192;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";
		+THRUACTORS;

		Tag "Sabot shells";
		Inventory.PickupMessage "You found 12ga sabot shells";
	}
	states
	{
		Spawn:
			DDAM H 1;
			Loop;
	}
}

class DDAmmo_30_06 : Ammo
{
	default
	{
		Inventory.Amount 8;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 96;
		Ammo.BackpackMaxAmount 192;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";

		Tag "30.06 Ammo";
		Inventory.PickupMessage "You found 30.06 ammo";
	}
	states
	{
		Spawn:
			DDAM I 1;
			Loop;
	}
}

class DDAmmo_ProdCharger : Ammo
{
	default
	{
		Inventory.Amount 6;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 40;
		Ammo.BackpackMaxAmount 80;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";
		Inventory.PickupMessage "You found a prod charger";

		Tag "Charger";
	}
	states
	{
		Spawn:
			DDAM J 1;
			Loop;
	}
}
class DDAmmo_PepperCartridge : Ammo
{
	default
	{
		Inventory.Amount 100;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 400;
		Ammo.BackpackMaxAmount 800;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";
		Inventory.PickupMessage "You found a pepper cartridge";

		Tag "Pepper cart.";
	}
	states
	{
		Spawn:
			DDAM K 1;
			Loop;
	}
}

class DDAmmo_PlasmaClip : Ammo
{
	default
	{
		Inventory.Amount 16;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 126;
		Ammo.BackpackMaxAmount 252;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";

		Tag "Plasma clip";
		Inventory.PickupMessage "You found a plasma clip";
	}
	states
	{
		Spawn:
			DDAM L 1;
			Loop;
	}
}

class DDAmmo_Napalm : Ammo
{
	default
	{
		Inventory.Amount 100;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 800;
		Ammo.BackpackMaxAmount 1600;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";

		Tag "Napalm";
		Inventory.PickupMessage "You found a napalm canister";
	}
	states
	{
		Spawn:
			DDAM M 1;
			Loop;
	}
}

class DDAmmo_Rockets : Ammo
{
	default
	{
		Inventory.Amount 4;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 50;
		Ammo.BackpackMaxAmount 100;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";

		Tag "Rockets";
		Inventory.PickupMessage "You found rockets";
	}
	states
	{
		Spawn:
			DDAM N 1;
			Loop;
	}
}
class DDAmmo_WPRockets : Ammo
{
	default
	{
		Inventory.Amount 4;
		Ammo.BackpackAmount 0;
		Inventory.MaxAmount 50;
		Ammo.BackpackMaxAmount 100;
		+THRUACTORS;
		Inventory.Icon "DXUIWP02";
		Inventory.AltHUDIcon "DXUIWP02";

		Tag "WP Rockets";
		Inventory.PickupMessage "You found white phosphorus rockets";
	}
	states
	{
		Spawn:
			DDAM O 1;
			Loop;
	}
}

class DDAmmoBox : DDItem
{ 
	default
	{
		Inventory.Amount 0;

		Radius 15;
		Height 15;
		Health 60;
		Mass 400;

		Tag "Ammo box";
	}
	states
	{
		Spawn:
			DDBX A 1;
			Loop;
	}

	override bool TryPickUp(Actor toucher)
	{
		for(uint i = 0; i < 2; ++i){
			Actor.Spawn("Clip", pos, ALLOW_REPLACE);
			Actor.Spawn("Shell", pos, ALLOW_REPLACE);
			Actor.Spawn("RocketAmmo", pos, ALLOW_REPLACE);
			Actor.Spawn("Cell", pos, ALLOW_REPLACE);
		}
		A_StartSound("DDItem/item_pickup");
		return false;
	}
}
