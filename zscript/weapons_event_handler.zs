class DDWeapons_EventHandler : StaticEventHandler
{
	int skill_id_heavy;
	int skill_id_pistol;
	int skill_id_rifle;
	int skill_id_lowtech;
	int skill_id_demolition;

	override void OnRegister()
	{
		let sk = DD_EventHandler(StaticEventHandler.Find("DD_EventHandler")).skill_utils;
		skill_id_heavy = sk.registerSkill("Weapons: Heavy", "The use of heavy weaponry.", TexMan.CheckForTexture("DXSKL01"), 1350, 2700, 4500);
		skill_id_pistol = sk.registerSkill("Weapons: Pistol", "The use of hand-held weapons.", TexMan.CheckForTexture("DXSKL02"), 1350, 2700, 4500);
		skill_id_rifle = sk.registerSkill("Weapons: Rifle", "The use of rifles.", TexMan.CheckForTexture("DXSKL03"), 1575, 3150, 5250);
		skill_id_lowtech = sk.registerSkill("Weapons: Low-Tech", "The use of melee weapons.", TexMan.CheckForTexture("DXSKL04"), 1350, 2700, 4500);
		skill_id_demolition = sk.registerSkill("Weapons: Demolition", "The use of thrown, explosive devices.", TexMan.CheckForTexture("DXSKL05"), 900, 1800, 3000);

		DD_InventoryHolder.addItemDescriptor("DDWeapon_Pistol", 1, 1, 1, -3, 3, 0.8, "A standard 10mm pistol.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_StealthPistol", 1, 1, 1, -2.5, 2.5, 1,
											"The stealth pistol is a variant of the standard 10mm\n"
											"pistol with a larger clip and integrated\n"
											"silencer designed for wet work at very close\n"
											"ranges.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_MiniCrossbow", 1, 1, 1, -2, -1, 1.2,
											"The mini-crossbow was specifically developed\n"
											"for espionage work, and accepts a range of dart\n"
											"types (normal, tranquilizer, or flare) that can be\n"
											"changed depending upon the mission requirements.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_PS20", 1, 1, 4, 1, 1, 1,
											"The PS20 is a disposable, plasma-based weapon\n"
											"developed by an unknown security organization as\n"
											"a next generation stealth pistol. Unfortunately,\n"
											"the necessity of maintaining a small physical\n"
											"profile restricts the weapon to a single shot.\n"
											"Despite its limited functionality, the PS20 can be\n"
											"lethal at close range.");

		DD_InventoryHolder.addItemDescriptor("DDWeapon_AssaultRifle", 2, 2, 1, -2, 4, 0.75,
											"The 7.62x51mm assault rifle is designed for\n"
											"close-quarter combat, utilizing a shortened\n"
											"barrel and 'bullpup' design for increased\n"
											"maneuverability. An additional underhand 20mm HE\n"
											"launcher increases the rifle's effectiveness\n"
											"against a variety of targets.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_AssaultShotgun", 2, 2, 1, -2.2, 7, 0.6,
											"The assault shotgun (sometimes referred to as a\n"
											"'street sweeper') combines the best traits of a\n"
											"normal shotgun with a fully automatic feed that\n"
											"can clear an area of hostiles in a matter of\n"
											"seconds. Particularly effective in urban combat,\n"
											"the assault shotgun accepts either buckshot or\n"
											"sabot shells.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_SawedOffShotgun", 3, 1, 1, 2, -1, 1.3,
											"The sawed-off, pump-action shotgun features a\n"
											"truncated barrel resulting in a wide spread at\n"
											"close range and will accept either buckshot or\n"
											"sabot shells.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_SniperRifle", 4, 1, 1, 4.5, -1, 1.3,
											"The military sniper rifle is the superior tool for the\n"
											"interdiction of long-range targets. When coupled\n"
											"with the proven 30.06 round, a marksman can\n"
											"achieve tight groupings at better than 1 MOA\n"
											"(minute of angle) depending on environmental\n"
											"conditions.");

		DD_InventoryHolder.addItemDescriptor("DDWeapon_RiotProd", 1, 1, 1, 0, 0, 1,
											"The riot prod has been extensively used by security\n"
											"forces who wish to keep what remains of the\n"
											"crumbling peace and have found the prod to be a\n"
											"valuable tool. Its short range tetanizing effect\n"
											"is most effective when applied to the torso or\n"
											"when the subject is taken by surprise.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_DragonsToothSword", 4, 1, 1, 2, 0, 1.2,
											"The true weapon of a modern warrior, the Dragon's\n"
											"Tooth is not a sword in the traditional sense, but a\n"
											"nanotechnologically constructed blade that is\n"
											"dynamically 'forged' on command into a non-eutactic\n"
											"solid. Nanoscale whetting devices insure that the\n"
											"blade is both unbreakable and lethally sharp.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_Baton", 1, 1, 1, 0, 1, 1,
											"A hefty looking baton, typically used by riot\n"
											"police and national security forces to discourage\n"
											"civilian resistance.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_CombatKnife", 1, 1, 1, -1, 1, 1,
											"An ultra-high carbon stainless steel knife.\n");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_Crowbar", 2, 1, 1, 0, 0, 1,
											"A crowbar. Hit someone or something with it.\n"
											"Repeat.\n"
											"<UNATCO OPS FILE NOTE GH010-BLUE> Many\n"
											"crowbars we call 'murder of crowbars.' Always have\n"
											"one for kombat. Ha.\n"
											"-- Gunther Hermann <END NOTE>");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_Sword", 3, 1, 1, -1.5, -0.5, 1.25,
											"A rather nasty-looking sword.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_ThrowingKnives", 1, 1, 25, 0, 0, 1.1,
											"A favorite weapon of assassins in the Far East\n"
											"for centuries, throwing knives can be deadly\n"
											"when wielded by a master but are more generally\n"
											"used when it becomes desirable to send a message.\n"
											"The message is usually 'Your death is coming on\n"
											"swift feet.'");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_PepperGun", 1, 1, 1, -1.5, 0, 1,
											"The pepper gun will accept a number of commecrially\n"
											"available riot control agents in cartridge form\n"
											"and disperse them as a fine aerosol mist that can\n"
											"cause blindness or blistering at short-range.");

		DD_InventoryHolder.addItemDescriptor("DDWeapon_LAM", 1, 1, 15, 0, 0, 1.15,
											"A multi-functional explosive with electronic\n"
											"priming system that can either be thrown or\n"
											"attached to any surface with its polyhesive backing\n"
											"and used as a proximity mine.\n"
											"<UNATCO OPS FILE NOTE SC093-BLUE> Disarming\n"
											"a proximity device should only be attempted with\n"
											"the proper demolitions training. Trust me on this.\n"
											"-- Sam Carter\n"
											"<END NOTE>");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_GasGrenade", 1, 1, 15, 2.3, -0.5, 1.15,
											"Upon detonation, the gas grenade releases a\n"
											"large amount of CS (a military-grade 'tear gas'\n"
											"agent) over its area of effect. CS will cause\n"
											"irritation to all exposed mucous membranes leading\n"
											"to temporary blindness and uncontrolled coughing.\n"
											"Like a LAM, gas grenades can be attached to any\n"
											"surface.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_EMPGrenade", 1, 1, 15, 1.4, -0.2, 1.15,
											"The EMP grenade creates a localized pulse that\n"
											"will temporarily disable all electronics within\n"
											"its area of effect, including cameras and security\n"
											"grids. <UNATCO OPS FILE NOTE JR134-VIOLET>\n"
											"While nanotech augmentations are largely\n"
											"unaffected by EMP, experiments have shown that it\n"
											"WILL cause the spontaneous dissipation of stored\n"
											"bioelectric energy.\n"
											"-- Jaime Reyes <END NOTE>");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_ScrambleGrenade", 1, 1, 15, 2.0, -0.8, 1.25,
											"The detonation of a GUARDIAN scramble grenade\n"
											"broadcasts a short-range, polymorphic broadband\n"
											"assault on the command frequencies used by almost\n"
											"all bots manufactured since 2028. The ensuing\n"
											"electronic storm causes bots within its radius of\n"
											"effect to indiscriminately attack other bots until\n"
											"command control can be re-established. Like a LAM,\n"
											"scramble grenades can be attached to any surface.");

		DD_InventoryHolder.addItemDescriptor("DDWeapon_PlasmaRifle", 4, 2, 1, 0, 5, 0.7,
											"An experimental weapon that is currently being\n"
											"produced as a series of one-off prototypes, the\n"
											"plasma gun superheats slugs of magnetically-doped\n"
											"plastic and accelerates the resulting gas-liquid\n"
											"mix using an array of linear magnets. The resulting\n"
											"plasma stream is deadly when used against slow\n"
											"moving targets.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_LAW", 4, 1, 2, 4.5, -1.2, 1.3,
											"The LAW provides cheap, dependable anti-armor\n"
											"capability in the form of an integrated one-shot\n"
											"rocket and delivery system, though at the expense\n"
											"of any laser guidance. Like other heavy weapons,\n"
											"the LAW can slow agents who have not trained with\n"
											"it extensively.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_Flamethrower", 4, 2, 1, -0.3, 4.3, 0.75,
											"A portable flamethrower that discards the old and\n"
											"highly dangerous backpack fuel delivery system in\n"
											"favor of pressurized canisters of napalm.\n"
											"Inexperienced agents will find that a flamethrower\n"
											"can be difficult to maneuver, however.");
		DD_InventoryHolder.addItemDescriptor("DDWeapon_GEPGun", 4, 2, 1, -0.4, 2, 0.85,
											"The GEP gun is a relatively recent invention in the\n"
											"field of armaments: a portable, shoulder-mounted\n"
											"launcher that can fire rockets and laser guide them\n"
											"to their target with pinpoint accuracy. While\n"
											"suitable for high-threat combat situations, it can\n"
											"be bulky for those agents who have not grown\n"
											"familiar with it.");

		DD_InventoryHolder.addItemDescriptor("DDWeaponUpgrade_Accuracy", 1, 1, 8, 0, 0, 1.2,
		"When clamped to the frame of most projectile\n"
		"weapons, a harmonic balancer will dampen the\n"
		"vertical motion produced by firing a projectile,\n"
		"resulting in increased accuracy.\n"
		"\n"
		"<UNATCO OPS FILE NOTE SC108-BLUE> Almost\n"
		"any weapon that has a significant amount of\n"
		"vibration can be modified with a balancer; I've\n"
		"event seen it work with the mini-crossbow and a\n"
		"prorotype plasma gun. -- Sam Carter <END NOTE>");
		DD_InventoryHolder.addItemDescriptor("DDWeaponUpgrade_Clip", 1, 1, 8, 0, 0, 1.2,
		"An extended magazine that increases clip capacity\n"
		"beyond the factory default.");
		DD_InventoryHolder.addItemDescriptor("DDWeaponUpgrade_Recoil", 1, 1, 8, 0, 0, 1.2,
		"A stock cushioned with polycellular shock\n"
		"absorbing material will significantly reduce\n"
		"perceived recoil.");
		DD_InventoryHolder.addItemDescriptor("DDWeaponUpgrade_Reload", 1, 1, 8, 0, 0, 1.2,
		"A speed loader greatly decreases the time\n"
		"required to reload a weapon.");
		DD_InventoryHolder.addItemDescriptor("DDWeaponUpgrade_Silencer", 1, 1, 8, 0, 0, 1.2,
		"A silencer will muffle the muzzle crack caused\n"
		"by rapidly expanding gases left in the wake of\n"
		"a bullet leaving the gun barrel.\n"
		"\n"
		"<UNATCO OPS FILE NOTE SC108-BLUE> Obviously, a\n"
		"silencer is only effective with firearms.\n"
		"-- Sam Carter <END NOTE>");
		DD_InventoryHolder.addItemDescriptor("DDWeaponUpgrade_Laser", 1, 1, 8, 0, 0, 1.2,
		"A laser targeting dot eliminates any inaccuracy\n"
		"resulting from the inability to visually gauge a\n"
		"projectile's point of impact.");

		crosshair_tex[0] = TexMan.CheckForTexture("DXCRSH01");
		crosshair_tex[1] = TexMan.CheckForTexture("DXCRSH02");
		crosshair_tex[2] = TexMan.CheckForTexture("DXCRSH03");
		crosshair_tex[3] = TexMan.CheckForTexture("DXCRSH04");
		crosshair_tex[4] = TexMan.CheckForTexture("DXCRSH05");
		zoom_crosshair_tex = TexMan.CheckForTexture("DXCRSH06");

		ammo_bg = TexMan.CheckForTexture("DXUIWP00");
		ammo_frame = TexMan.CheckForTexture("DXUIWP01");
	}


	TextureID crosshair_tex[5];
	TextureID zoom_crosshair_tex;
	override void RenderUnderlay(RenderEvent e)
	{
		PlayerInfo plr = players[consoleplayer];
		if(plr.mo && plr.ReadyWeapon is "DDWeapon"){
			DDWeapon wep = DDWeapon(plr.ReadyWeapon);
			if(!wep.has_scope || !wep.zoomed_in){
				Shader.SetEnabled(players[consoleplayer], "DDShader_ZoomSniper", false);
				// Visualise spread
				double w = 8, h = 8;

				UI_Draw.texture(crosshair_tex[0], 160 - w/2, 100 - h/2, w, h);
				double fov = CVar.getCVar("fov", players[consoleplayer]).getFloat();
				double spread_angle = wep.GetCurrentSpread();
				double spread_x = (spread_angle / fov) * 220, spread_y = (spread_angle / fov) * 220;
				// FOV is basically an angle between leftmost/rightmost (topmost/bottom) sides of the screen
				if(wep.base_spread > 0){
					w = 5; h = 3.5; UI_Draw.texture(crosshair_tex[1], 160 - w/2, 100 - h/2 - spread_y - 5, w, h); // top
					UI_Draw.texture(crosshair_tex[2], 160 - w/2, 100 - h/2 + spread_y + 5, w, h); // bottom
					w = 3.7; h = 5; UI_Draw.texture(crosshair_tex[3], 160 - w/2 + spread_x + 5, 100 - h/2, w, h); // right
					w = 3; h = 5; UI_Draw.texture(crosshair_tex[4], 160 - w/2 - spread_x - 5, 100 - h/2, w, h); // left
				}
			}
			else{
				// Render scope crosshair
				if(wep.has_scope){
					Shader.SetEnabled(players[consoleplayer], "DDShader_ZoomSniper", true);
					Shader.SetUniform1f(players[consoleplayer], "DDShader_ZoomSniper", "aspect_ratio", Screen.GetAspectRatio());
					double w = 72;
					double h = 80;
					UI_Draw.texture(crosshair_tex[0], 160 - 2, 100 - 0.8, 4, 4);
					UI_Draw.texture(zoom_crosshair_tex, 160 - w/2 - 0.1, 100 - h/2, w, h);
				}
			}
		}
	}

	TextureID ammo_bg, ammo_frame;
	override void RenderOverlay(RenderEvent e)
	{
		let ddevh = DD_EventHandler(StaticEventHandler.Find("DD_EventHandler"));
		PlayerInfo plr = players[consoleplayer];
		if(plr.mo && plr.ReadyWeapon is "DDWeapon"){
			// Render ammo info
			double x = 283, y = 170;
			UI_Draw.texture(ammo_bg, x + 1, y + 5, 0, 21);
			UI_Draw.texture(ammo_frame, x, y, 0, 30, UI_Draw_FlipX);

			UI_Draw.str(ddevh.aug_ui_font, "AMMO", 0xFFFFFF, x + 21.5, y + 7, 0, 3);
			UI_Draw.str(ddevh.aug_ui_font, "CLIPS", 0xFFFFFF, x + 21, y + 19.5, 0, 3);

			DDWeapon wep = DDWeapon(plr.ReadyWeapon);
			int clipcnt = wep.GetClipSize() > 0 ? ceil(plr.mo.CountInv(wep.current_ammo_type) / double(wep.GetClipSize())) : 0;

			UI_Draw.texture(wep.AltHUDIcon, x + 12 - UI_Draw.texWidth(wep.AltHUDIcon, 0, 13) / 2, y + 8, 0, 13);

			let ddih = DD_InventoryHolder(plr.mo.FindInventory("DD_InventoryHolder"));
			int wep_inv_idx = -1;
			for(int i = 0; i < ddih.items.size(); ++i)
				if(ddih.items[i].item == wep)
				{ wep_inv_idx = i; break; }

			/* Draw ammo in clip */
			UI_Draw.str(ddevh.aug_ui_font, wep.AmmoType1 ? String.Format("%d", wep.chambered_ammo)
											: (wep.uses_self && wep_inv_idx != -1) ? String.Format("%d", ddih.items[wep_inv_idx].amount) : "N/A",
											wep.chambered_ammo > wep.GetClipSize() / 3. ? 0x00FF00 :
											(wep.uses_self && wep_inv_idx != -1 && ddih.items[wep_inv_idx].amount > ddih.items[wep_inv_idx].max_stack / 4.) ? 0x00FF00 :
											(!wep.AmmoType1) ? 0x00FF00 : 0xFF0000,
											x + 22.5, y + 11, 0, 3);
			/* Draw reserve clip count */
			UI_Draw.str(ddevh.aug_ui_font, (wep.AmmoType1 && wep.GetClipSize() > 0) ? String.Format("%d", clipcnt) : "N/A",
											(clipcnt > 2 || !wep.AmmoType1 || wep.GetClipSize() == 0) ? 0x00FF00 : 0xFF0000,
											x + 22.5, y + 15.5, 0, 3.5);
			/* Draw lock-on time remaining */
			if(wep.has_lockon && wep.lockon_timer > 0 && (!wep.IsLockedOn() || wep.aimed_at)){
				string text = wep.IsLockedOn() ? String.Format("LOCKED %.0f FT", wep.owner.Distance3D(wep.aimed_at) / 32 * 3.28) : String.Format("REQUIRE %.2f SEC", (wep.GetLockOnTime() - wep.lockon_timer) / 35.);
				UI_Draw.str(ddevh.aug_ui_font, text, wep.IsLockedOn() ? 0xFF0000 : 0xFFFF00,
											x + 16 - UI_Draw.strWidth(ddevh.aug_ui_font, text, 0, 2.5)/2, y + 23, 0, 2.5);
			}
		}
	}

	override void NetworkProcess(ConsoleEvent e)
	{
		PlayerInfo plr = players[e.Player];
		if(!plr || !plr.mo)
			return;

		if(e.name == "dd_inventory_change_ammo"){
			let ddih = DD_InventoryHolder(plr.mo.FindInventory("DD_InventoryHolder"));
			if(e.args[0] < ddih.items.size())
				if(ddih.items[e.args[0]].item is "DDWeapon"){
					let wep = DDWeapon(ddih.items[e.args[0]].item);
					wep.CycleAmmoType();
				}
		}
		else if(e.name == "dd_curwep_change_ammo"){
			if(plr.ReadyWeapon && plr.ReadyWeapon is "DDWeapon"){
				DDWeapon wep = DDWeapon(plr.ReadyWeapon);
				wep.CycleAmmoType();
			}
		}
	}

	override void CheckReplacement(ReplaceEvent e)
	{
		let spawn_utils = DD_EventHandler(StaticEventHandler.Find("DD_EventHandler")).spawn_utils;
		if(e.replacement && e.replacee) // it's crucial to repeat this line in every submod to save replacements recieved from other mods
			spawn_utils.addModReplacee(e.replacee, e.replacement);

		if(e.replacee == "Clip")
			e.replacement = "DDSpawner_Clip";
		else if(e.replacee == "ClipBox")
			e.replacement = "DDSpawner_ClipBox";
		else if(e.replacee == "Shell")
			e.replacement = "DDSpawner_Shell";
		else if(e.replacee == "ShellBox")
			e.replacement = "DDSpawner_ShellBox";
		else if(e.replacee == "RocketAmmo")
			e.replacement = "DDSpawner_RocketAmmo";
		else if(e.replacee == "RocketBox")
			e.replacement = "DDSpawner_RocketBox";
		else if(e.replacee == "Cell")
			e.replacement = "DDSpawner_Cell";
		else if(e.replacee == "CellPack")
			e.replacement = "DDSpawner_CellPack";

		else if(e.replacee == "Pistol")
			e.replacement = "DDSpawner_Pistol";
		else if(e.replacee == "Chainsaw")
			e.replacement = "DDSpawner_Chainsaw";
		else if(e.replacee == "Shotgun")
			e.replacement = "DDSpawner_Shotgun";
		else if(e.replacee == "SuperShotgun")
			e.replacement = "DDSpawner_SuperShotgun";
		else if(e.replacee == "Chaingun")
			e.replacement = "DDSpawner_Chaingun";
		else if(e.replacee == "RocketLauncher")
			e.replacement = "DDSpawner_RocketLauncher";
		else if(e.replacee == "PlasmaRifle")
			e.replacement = "DDSpawner_PlasmaRifle";
		else if(e.replacee == "BFG9000")
			e.replacement = "DDSpawner_BFG9000";

		else if(e.replacee == "Soulsphere")
			e.replacement = "DDSpawner_Soulsphere";
		else if(e.replacee == "Megasphere")
			e.replacement = "DDSpawner_Megasphere";
		else if(e.replacee == "BlurSphere")
			e.replacement = "DDSpawner_BlurSphere";
		else if(e.replacee == "Infrared")
			e.replacement = "DDSpawner_Infrared";

		else if(e.replacee == "Backpack")
			e.replacement = "DDSpawner_Backpack";
	}

	override void WorldTick()
	{
		if(level.MapName == "TITLEMAP")
			return;

		for(uint i = 0; i < MAXPLAYERS; ++i){
			if(!playeringame[i] || !players[i].mo || players[i].mo.CountInv("DD_PistolStartedToken") > 0)
				continue;

			PlayerInfo plr = players[i];
			// Pistol start
			plr.mo.TakeInventory("Fist", 1);
			plr.mo.TakeInventory("Pistol", 1);
			plr.mo.TakeInventory("Clip", 50);
		
			DD_InventoryHolder ddih = DD_InventoryHolder(plr.mo.FindInventory("DD_InventoryHolder"));
			if(!ddih){
				ddih = DD_InventoryHolder(Inventory.Spawn("DD_InventoryHolder"));
				plr.mo.addInventory(ddih);
			}

			let pistol = DDWeapon(Actor.Spawn("DDWeapon_Pistol", (999999, 999999, 999999)));
			pistol.chambered_ammo = pistol.GetClipSize();
			ddih.addItem(pistol);
			let knife = Inventory(Actor.Spawn("DDWeapon_CombatKnife", (999999, 999999, 999999)));
			ddih.addItem(knife);

			plr.mo.GiveInventory("DDAmmo_10mm", 12);

			plr.mo.PickNewWeapon(null);
			plr.mo.GiveInventory("DD_PistolStartedToken", 1);
		}
	}
}

class DD_PistolStartedToken : Inventory {} // Just marks whether the player had their pistol start items given already or not
