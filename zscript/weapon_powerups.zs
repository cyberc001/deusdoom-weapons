class DDPowerup : Powerup
{
	default
	{
		+DONTGIB; 
		+THRUACTORS;
	}
}

class DDPowerup_TranqPoison : DDPowerup
{
	int dur_timer;
	const duration = 35*16;
	const dmg_freq = 35*2;
	const maxhp_dmgbonus = 0.04;
	const maxhp_maxdmgbonus = 70;
	int dmg;

	override void BeginPlay()
	{
		super.BeginPlay();
		dur_timer = duration;
	}
	override void Tick()
	{
		if(dur_timer % dmg_freq == 0 && owner){
			if(owner.bISMONSTER) owner.triggerPainChance("None", true);
			double maxhp_dmg = owner.SpawnHealth() * maxhp_dmgbonus;
			if(maxhp_dmg > maxhp_maxdmgbonus) maxhp_dmg = maxhp_maxdmgbonus;
			owner.damageMobj(self, target, dmg + maxhp_dmg, "None");
		}
		--dur_timer;
		if(dur_timer <= 0){
			DetachFromOwner();
			Destroy();
		}
	}
}

class DDPowerup_PlayerGasPoison : DDPowerup
{
	int dur_timer;
	const duration = 35*2;
	const dmg = 2;

	override void BeginPlay()
	{
		super.BeginPlay();
		dur_timer = duration;
	}
	override void Tick()
	{
		if(dur_timer == duration){
			owner.triggerPainChance("None", true);
			owner.damageMobj(self, self, dmg, "None");
		}
		--dur_timer;
		if(dur_timer <= 0){
			DetachFromOwner();
			Destroy();
		}
	}
}

class DDPowerup_Stun : DDPowerup
{
	default
	{
		DDPowerup_Stun.Duration 35*15;
		DDPowerup_Stun.BossDuration 35*3;
		DDPowerup_Stun.DurationDecreaseHpMin 100;
		DDPowerup_Stun.DurationDecreaseHpMax 800;
		DDPowerup_Stun.DurationDecreaseMax 35*12;
		DDPowerup_Stun.PainDelayMin 20;
		DDPowerup_Stun.PainDelayMax 35*3;
		DDPowerup_Stun.PainSoundOnFirstTick true;
	}

	int dur_timer;

	int duration;
	property Duration: duration;
	int boss_duration;
	property BossDuration: boss_duration;
	int duration_dec_hpmin;
	property DurationDecreaseHpMin: duration_dec_hpmin;
	int duration_dec_hpmax;
	property DurationDecreaseHpMax: duration_dec_hpmax;
	int duration_dec_max;
	property DurationDecreaseMax: duration_dec_max;

	bool activated;
	int pain_timer;

	int pain_delay_min;
	property PainDelayMin: pain_delay_min;
	int pain_delay_max;
	property PainDelayMax: pain_delay_max;

	string prev_pain_sound;

	bool pain_sound_on_first_tick;
	property PainSoundOnFirstTick: pain_sound_on_first_tick;

	virtual int GetDuration()
	{
		return owner.bBOSS ? boss_duration : duration - duration_dec_max * (owner.GetSpawnHealth() > duration_dec_hpmax ? 1
																						: owner.GetSpawnHealth() < duration_dec_hpmin ? 0
																						: double(owner.GetSpawnHealth() - duration_dec_hpmin) / (duration_dec_hpmax - duration_dec_hpmin));
	}

	override void Tick()
	{
		if(owner)
			owner.triggerPainChance("None", true);

		if(owner && !activated){
			prev_pain_sound = owner.PainSound;
			owner.PainSound = "";

			dur_timer = GetDuration();
			if(prev_pain_sound && pain_sound_on_first_tick){
				warp(owner);
				A_StartSound(owner.PainSound);
			}
			activated = true;
			pain_timer = random(pain_delay_min, pain_delay_max);
		}

		--pain_timer;
		if(pain_timer <= 0){
			if(owner && prev_pain_sound){
				warp(owner);
				A_StartSound(owner.PainSound);
			}
			pain_timer = random(pain_delay_min, pain_delay_max);
		}
		--dur_timer;
		if(dur_timer <= 0 || !owner || owner.health <= 0){
			if(owner){
				DetachFromOwner();
				owner.PainSound = prev_pain_sound;
			}
			Destroy();
		}
	}

	override void ModifyDamage(int damage, Name damageType, out int newdamage, bool passive, Actor inflictor, Actor source, int flags)
	{
		if(passive && !owner.bBOSS)
			newdamage = damage * 2;
	}
}

class DDPowerup_PepperStun : DDPowerup_Stun
{
	default
	{
		DDPowerup_Stun.Duration 35*8;
		DDPowerup_Stun.BossDuration 35*2;
		DDPowerup_Stun.DurationDecreaseHpMin 100;
		DDPowerup_Stun.DurationDecreaseHpMax 1000;
		DDPowerup_Stun.DurationDecreaseMax 35*6;
		DDPowerup_Stun.PainDelayMin 20;
		DDPowerup_Stun.PainDelayMax 35;
	}
}

class DDPowerup_GasStun : DDPowerup_Stun
{
	default
	{
		DDPowerup_Stun.Duration 35*2;
		DDPowerup_Stun.BossDuration 35*1;
		DDPowerup_Stun.DurationDecreaseHpMin 100;
		DDPowerup_Stun.DurationDecreaseHpMax 600;
		DDPowerup_Stun.DurationDecreaseMax 35;
		DDPowerup_Stun.PainDelayMin 35;
		DDPowerup_Stun.PainDelayMax 55;
		DDPowerup_Stun.PainSoundOnFirstTick false;
	}

	// Cooldown of stun in terms of fractions of duration
	const cd_frac_min = 0.05;
	const cd_frac_max = 0.8;
	const cd_frac_boss = 1.2;

	int cd_timer;

	int GetCD()
	{
		return GetDuration() * (owner.bBOSS ? cd_frac_boss : cd_frac_min + (cd_frac_max - cd_frac_min) * (owner.GetSpawnHealth() > duration_dec_hpmax ? 1
																						: owner.GetSpawnHealth() < duration_dec_hpmin ? 0
																						: double(owner.GetSpawnHealth() - duration_dec_hpmin) / (duration_dec_hpmax - duration_dec_hpmin)));
	}


	override void BeginPlay()
	{
		super.BeginPlay();
		cd_timer = -1;
	}

	override void Tick()
	{
		if(cd_timer == -1 && owner)
			cd_timer = GetCD();
		if(dur_timer <= 0 && cd_timer > 0)
			--cd_timer;
		else
			super.Tick();
	}
}

class DDPowerup_EMPStun : DDPowerup_Stun
{
	default
	{
		DDPowerup_Stun.Duration 35*30;
		DDPowerup_Stun.BossDuration 35*10;
		DDPowerup_Stun.DurationDecreaseHpMin 1;
		DDPowerup_Stun.DurationDecreaseHpMax 1;
		DDPowerup_Stun.DurationDecreaseMax 0;
		DDPowerup_Stun.PainDelayMin 80;
		DDPowerup_Stun.PainDelayMax 150;
	}

	double dur_coff;
	override int GetDuration() { return super.GetDuration() * dur_coff; }
}

class DDPowerup_Scramble : DDPowerup_Stun
{
	default
	{
		DDPowerup_Stun.Duration 35*40;
		DDPowerup_Stun.BossDuration 35*15;
		DDPowerup_Stun.DurationDecreaseHpMin 1;
		DDPowerup_Stun.DurationDecreaseHpMax 1;
		DDPowerup_Stun.DurationDecreaseMax 0;
	}

	double dur_coff;
	override int GetDuration() { return super.GetDuration() * dur_coff; }

	override void Tick()
	{
		if(owner && !activated){
			dur_timer = GetDuration();
			activated = true;
			owner.bFRIENDLY = !owner.bFRIENDLY;
		}

		--dur_timer;
		if(dur_timer <= 0 || !owner || owner.health <= 0){
			if(owner){
				owner.bFRIENDLY = !owner.bFRIENDLY;
				owner.target = null;
				DetachFromOwner();
			}
			Destroy();
		}
	}
}

class DDPowerup_Burn : DDPowerup
{
	int dur_timer;
	const duration = 35*15;
	const dmg_freq = 35;
	const maxhp_dmgbonus = 0.075;
	const maxhp_maxdmgbonus = 12;
	int dmg;

	bool activated;
	array<DDEffect_BurningFire> bfire_effects;

	string burn_sound;
	int burn_schannel;

	override void BeginPlay()
	{
		super.BeginPlay();
		dur_timer = duration;
	}

	override void Tick()
	{
		if(!activated && owner){
			activated = true;
			for(uint i = 0; i < 2; ++i){
				let bf = DDEffect_BurningFire(Actor.Spawn("DDEffect_BurningFire"));
				bf.target = owner;
				bf.warp_off = (0, 0, owner.height / 4 + i * owner.height / 3);
				bf.scale *= (owner.radius / 20) * 0.7 + 0.15;
				bfire_effects.push(bf);
			}
			burn_sound = owner.SpawnHealth() < 130 ? (random(0,1) ? "DDFire/small1" : "DDFire/small2")
						: (owner.SpawnHealth() < 500 && !owner.bBOSS) ? (random(0,1) ? "DDFire/medium1" : "DDFire/medium2")
						: "DDFire/large";
			burn_schannel = random(128, 32000);
			A_StartSound(burn_sound, burn_schannel, CHANF_LOOP);
		}

		if(owner)
			warp(owner);

		if(dur_timer % dmg_freq == 0 && owner){
			double maxhp_dmg = owner.SpawnHealth() * maxhp_dmgbonus;
			if(maxhp_dmg > maxhp_maxdmgbonus) maxhp_dmg = maxhp_maxdmgbonus;
			owner.damageMobj(self, target, dmg + maxhp_dmg, "Fire");
		}
		--dur_timer;
		if(dur_timer <= 0 || !owner || owner.health <= 0){
			if(owner)
				DetachFromOwner();
			Destroy();
		}
	}

	override void OnDestroy()
	{
		for(uint i = 0; i < bfire_effects.size(); ++i)
			if(bfire_effects[i])
				bfire_effects[i].Destroy();
		A_StopSound(burn_schannel);

		super.OnDestroy();
	}
}
