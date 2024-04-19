
get_config( dataName )
{
	return self getStat( int( tableLookup( "promod/customStatsTable.csv", 1, dataName, 0 ) ) );
}

set_config( dataName, value )
{
	self setStat( int( tableLookup( "promod/customStatsTable.csv", 1, dataName, 0 ) ), value );
	return value;
}

toggle(name)
{
	return self set_config( name, int(!self get_config(name)) );
}

loopthrough(name, limit)
{
	value = self get_config(name)+1;
	if(value > limit) value = 0;
	return self set_config(name, value);
}

setsunlight(n)
{
	sl = 0;
	slsetting = "Off";
	if ( !n )
	{
		sl = 1.2;
		slsetting = 1.2;
	}
	else if ( n == 1 && isDefined(level.sunlight) )
	{
		slsetting = "Stock";
		sl = level.sunlight;
	}
	self setclientdvars("r_lighttweaksunlight", sl, "sunlight", slsetting);
}

use_config()
{
	self setsunlight(self get_config("PROMOD_SUNLIGHT"));
	self setClientDvars(
	"aim_automelee_enabled", 0,
	"aim_automelee_range", 0,
	"dynent_active", 0,
	"snaps", 30,
	"cg_nopredict", 0,
	"cg_crosshairenemycolor", 0,
	"sm_enable", 0,
	"r_dlightlimit", 0,
	"r_lodscalerigid", 1,
	"r_lodscaleskinned", 1,
	"cg_drawcrosshairnames", 0,
	"cg_descriptivetext", 0,
	"cg_viewzsmoothingmin", 1,
	"cg_viewzsmoothingmax", 16,
	"cg_viewzsmoothingtime", 0.1,
	"cg_huddamageiconheight", 64,
	"cg_huddamageiconwidth", 128,
	"cg_huddamageiconinscope", 0,
	"cg_huddamageiconoffset", 128,
	"cg_huddamageicontime", 2000,
	"ragdoll_enable", 0,
	"r_filmtweakinvert", 0,
	"r_desaturation", 0,
	"r_dlightlimit", 0,
	"r_fog", 0,
	"r_specularcolorscale", 0,
	"r_zfeather", 0,
	"fx_drawclouds", 0,
	"rate", 25000,
	"cl_maxpackets", 125,
	"developer", 0,
	"phys_gravity", -800,
	"r_normalmap", self get_config("PROMOD_NORMALMAP"),
	"r_texfilterdisable", self get_config("PROMOD_TEXTURE"),
	"r_filmusetweaks", self get_config("PROMOD_FILMTWEAK"),
	"r_blur", 0.2*self get_config("PROMOD_GFXBLUR"),
	"cg_fovscale", 1+int(!self get_config("PROMOD_FOVSCALE"))*0.125);
}
