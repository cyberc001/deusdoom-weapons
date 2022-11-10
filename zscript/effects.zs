#include "zscript/effects/plasma_smoke.zs"
#include "zscript/effects/smoke_trail.zs"
#include "zscript/effects/explosion.zs"
#include "zscript/effects/energy_sphere.zs"
#include "zscript/effects/tear_gas.zs"
#include "zscript/effects/steam.zs"
#include "zscript/effects/gas_cloud.zs"
#include "zscript/effects/emp_sphere.zs"
#include "zscript/effects/burning_fire.zs"

class DDAnimatedEffect : Actor
{
	default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;
	}

	double scale_start;
	property ScaleStart : scale_start;
	double scale_end;
	property ScaleEnd : scale_end;
	double alpha_start;
	property AlphaStart : alpha_start;
	double alpha_end;
	property AlphaEnd : alpha_end;
	int anim_dur;
	property AnimDuration : anim_dur;
	int anim_timer;
	
	override void BeginPlay()
	{
		super.BeginPlay();
		A_SetScale(scale_start);
		A_SetRenderStyle(alpha_start, STYLE_Translucent);
	}
	override void Tick()
	{
		super.Tick();
		A_SetScale(scale_start + (double(anim_timer) / anim_dur) * (scale_end - scale_start));
		A_SetRenderStyle(alpha_start + (double(anim_timer) / anim_dur) * (alpha_end - alpha_start), STYLE_Translucent);
		if(anim_timer < anim_dur)
			++anim_timer;
	}
}

class DDAnimatedProjectile : DDProjectile
{
	default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;
	}

	double scale_start;
	property ScaleStart : scale_start;
	double scale_end;
	property ScaleEnd : scale_end;
	double alpha_start;
	property AlphaStart : alpha_start;
	double alpha_end;
	property AlphaEnd : alpha_end;
	int anim_dur;
	property AnimDuration : anim_dur;
	int anim_timer;
	
	override void BeginPlay()
	{
		super.BeginPlay();
		A_SetScale(scale_start);
		A_SetRenderStyle(alpha_start, STYLE_Translucent);
	}
	override void Tick()
	{
		super.Tick();
		A_SetScale(scale_start + (double(anim_timer) / anim_dur) * (scale_end - scale_start));
		A_SetRenderStyle(alpha_start + (double(anim_timer) / anim_dur) * (alpha_end - alpha_start), STYLE_Translucent);
		if(anim_timer < anim_dur)
			++anim_timer;
	}
}
