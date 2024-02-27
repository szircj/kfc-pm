#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
//#include maps\mp\gametypes\_endroundmusic;

finalKillcamWaiter()
{
	if ( !level.inFinalKillcam )
		return;
		
	while (level.inFinalKillcam)
		wait(0.05);
}

postRoundFinalKillcam()
{
	level notify( "play_final_killcam" );
	song = (1+randomInt(7));
	//level thread playSoundOnAllPlayers( "endround" + song );
	//level thread displaysName_hud( "endround" + song );
	maps\mp\gametypes\_globallogic_utils::resetOutcomeForAllPlayers();
	finalKillcamWaiter();	
}

startFinalKillcam( 
	attackerNum,
	targetNum,
	killcamentityindex,
	sWeapon,
	deathTime,
	deathTimeOffset,
	offsetTime, 
	attacker,
	victim
)
{
	if(attackerNum < 0)
		return;
	recordKillcamSettings( attackerNum, targetNum, sWeapon, deathTime, deathTimeOffset, offsetTime, attacker, killcamentityindex, victim );
	startLastKillcam();
}

startLastKillcam()
{
	if ( level.inFinalKillcam )
		return;

	if ( !isDefined(level.lastKillCam) )
		return;
	
	level.inFinalKillcam = true;
	level waittill ( "play_final_killcam" );

	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		player closeMenu(); 
		player closeInGameMenu();
		player thread finalKillcam();
	}
	
	wait( 0.1 );

	while ( areAnyPlayersWatchingTheKillcam() )
		wait( 0.05 );

	level.inFinalKillcam = false;
}


areAnyPlayersWatchingTheKillcam()
{
	players = level.players;
	for ( index = 0; index < players.size; index++ )
	{
		player = players[index];
		if ( isDefined( player.killcam ) )
			return true;
	}
	
	return false;
}

waitKillcamTime()
{
	self endon("disconnect");
	self endon("end_finalkillcam");

	wait(self.killcamlength - 0.07);
	self notify("end_finalkillcam");
}

displaysName_hud( song ){
players = level.players;
for ( index = 0; index < players.size; index++ ){
		player = players[index];
		player thread displayone(song);

}

}
//Function is Developed by MaNa 
displayone( song ) { 
		notifyData = spawnstruct();
		notifyData.notifyText =  "^1Song Name"; //Title
		notifyData.notifyText2 = (getS_name(song));; //Name Song
		notifyData.glowColor = (0, 0, 1); //RGB Color array divided by 100
		notifyData.duration = 6.0;
		self thread maps\mp\gametypes\_hud_message::notifyMessage( notifyData );
}

addTextHud( who, x, y, alpha, alignX, alignY, vert, fontScale, sort ) { //stealed braxis function like a boss xD
	if( isPlayer( who ) ) hud = newClientHudElem( who );
	else hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.alignX = alignX;
	hud.alignY = alignY;
	if(isdefined(vert))
		hud.horzAlign = vert;
	if(fontScale != 0)
		hud.fontScale = fontScale;
	hud.archived = false;
	return hud;
}

getS_name(song)
{
	switch( song )
	{

		case "endround1":
			return "Grandtheft & Delaney Jane - Eazy Go"; //Change These as your music on the server
			
		case "endround2":
			return "Calvin Harrid - How Deep is your love";
			
		case "endround3":
			return "Cartoon - On & On";
			
		case "endround4":
			return "Eminem - Not Afraid";
			
		case "endround5": 
			return "Jonas Blue - Mama ft. William Singe";

		case "endround6":
			return "Eminem - The Monster ft. Rihanna";

		case "endround7":
			return "OneRepublic - Counting Stars";

		case "endround8":
			return "Unknown";
			
		case "endround9":
			return "Krewella - Alive";
			
		case "endround10":
			return "Sia - Cheap Thrills Ft. Sean Paul";
			
		case "endround11":
			return "Pitbull & J Balvin - Hey Ma ft Camila Cabello";
			
		case "endround12":
			return "Sia - Never Give Up";
			
		case "endround13": 
			return "Sia - The Greatest ft. Kendrick Lamar";

		case "endround14":
			return "ItaloBrothers - Summer Air";

		case "endround15":
			return "Linkin Park - Numb";

		case "endround16":
			return "Kanye West - Stronger";
			
		case "endround17":
		return "Linkin Park - In The End";
			
		case "endround18":
		return "Axwell - Ingrosso - More Than You Knowr";
		
		case "endround19":
		return "Fort Minor - Remember The Name";
			
		case "endround20":
		return "Kelly Clarkson - Stronger";
			
		case "endround21":
		return "Pitbull & J Balvin - Hey Ma ft Camila Cabello";
		
		case "endround22":
		return "Macklemore & Ryan Lewis - Thrift Shop";
			
		case "endround23":
		return "The Script - Superheroes";

		case "endround24":
		return "Rihanna feat Drake - Work";		
						
		case "endround25":
			return "Clean Bandit - Rockabye ft. Sean Paul & Anne-Marie";
			
		default:
			return "";
	}
}

waitFinalKillcamSlowdown( startTime )
{
	self endon("disconnect");
	self endon("end_finalkillcam");
	secondsUntilDeath = ( ( level.lastKillCam.deathTime - startTime ) / 1000 );
	deathTime = getTime() + secondsUntilDeath * 1000;
	waitBeforeDeath = 2;
	wait( max(0, (secondsUntilDeath - waitBeforeDeath) ) );
	setTimeScale( 1, int( deathTime - 500 ));
	wait( waitBeforeDeath );
	setTimeScale(1,getTime());
}
setTimeScale(to,time)
{
	difference = (abs(getTime() - time)/1000);
	timescale = getDvarFloat("timescale");
	if(difference != 0) 
	{
		for(i = timescale*20; i >= to*20; i -= 1 )
		{
			wait ((int(difference)/int(getDvarFloat("timescale")*20))/20);
			setDvar("timescale",i/20);
		} 
	}
	else
	setDvar("timescale",to);
}
endKillcam()
{
	if(isDefined(self.fkc_timer))
		self.fkc_timer.alpha = 0;
		
	if(isDefined(self.killertext))
	self.killertext.alpha = 0;
			
	self.killcam = undefined;
	
}

checkForAbruptKillcamEnd()
{
	self endon("disconnect");
	self endon("end_finalkillcam");
	
	while(1)
	{
		if ( self.archivetime <= 0 )
			break;
		wait .05;
	}
	
	self notify("end_finalkillcam");
}
checkPlayers()
{
	self endon("disconnect");
	self endon("end_finalkillcam");
	
	while(1)
	{
		if(! isDefined(maps\mp\gametypes\_globallogic::getPlayerFromClientNum(level.lastKillCam.spectatorclient)) )
			break;
		wait 0.05;
	}
	self notify("end_finalkillcam");
}
recordKillcamSettings( spectatorclient, targetentityindex, sWeapon, deathTime, deathTimeOffset, offsettime, attacker, entityindex, victim )
{
	if ( ! isDefined(level.lastKillCam) )
		level.lastKillCam = spawnStruct();
	
	level.lastKillCam.spectatorclient = spectatorclient;
	level.lastKillCam.weapon = sWeapon;
	level.lastKillCam.deathTime = deathTime;
	level.lastKillCam.deathTimeOffset = deathTimeOffset;
	level.lastKillCam.offsettime = offsettime;
	level.lastKillCam.targetentityindex = targetentityindex;
	level.lastKillCam.attacker = attacker;
	level.lastKillCam.entityindex = entityindex;
	level.lastKillCam.victim = victim;
}

finalKillcam()
{
	self endon("disconnect");
	level endon("game_ended");
	
	self notify( "end_killcam" );

	self setClientDvar("cg_airstrikeKillCamDist", 20);
	
	postDeathDelay = (getTime() - level.lastKillCam.deathTime) / 1000;
	predelay = postDeathDelay + level.lastKillCam.deathTimeOffset;

	camtime = calcKillcamTime( level.lastKillCam.weapon, predelay, false, undefined );
	postdelay = calcPostDelay();

	killcamoffset = camtime + predelay;
	killcamlength = camtime + postdelay - 0.05;

	killcamstarttime = (gettime() - killcamoffset * 1000);

	self notify ( "begin_killcam", getTime() );

	self.sessionstate = "spectator";
	self.spectatorclient = level.lastKillCam.spectatorclient;
	self.killcamentity = -1;
	if ( level.lastKillCam.entityindex >= 0 )
		self thread setKillCamEntity( level.lastKillCam.entityindex, 0 - killcamstarttime - 100 );
	self.killcamtargetentity = level.lastKillCam.targetentityindex;
	self.archivetime = killcamoffset;
	self.killcamlength = killcamlength;
	self.psoffsettime = level.lastKillCam.offsettime;

	self allowSpectateTeam("allies", true);
	self allowSpectateTeam("axis", true);
	self allowSpectateTeam("freelook", false);
	self allowSpectateTeam("none", false);

	wait 0.05;

	if ( self.archivetime <= predelay )
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;

		self notify ( "end_finalkillcam" );
		
		return;
	}
	
	self thread checkForAbruptKillcamEnd();
	self thread checkPlayers();

	self.killcam = true;

	self addKillcamTimer(camtime);
	self addKillcamKiller(level.lastKillCam.attacker,level.lastKillCam.victim);
	
	self thread waitKillcamTime();
	self thread waitFinalKillcamSlowdown( killcamstarttime );

	self waittill("end_finalkillcam");
	
	self.villain destroy();
	self.versus destroy();
	self.victim destroy();

	self endKillcam();
}

isKillcamGrenadeWeapon( sWeapon )
{
	if (sWeapon == "frag_grenade_mp")
		return true;
		
	else if (sWeapon == "frag_grenade_short_mp"  )
		return true;
	
	return false;
}
calcKillcamTime( sWeapon, predelay, respawn, maxtime )
{
	camtime = 0.0;
	
	if ( isKillcamGrenadeWeapon( sWeapon ) )
	{
		camtime = 4.25; 
	}
	else
		camtime = 5;
	
	if (isdefined(maxtime)) {
		if (camtime > maxtime)
			camtime = maxtime;
		if (camtime < .05)
			camtime = .05;
	}
	
	return camtime;
}

calcPostDelay()
{
	postdelay = 0;
	
		// time after player death that killcam continues for
	if (getDvar( "scr_killcam_posttime") == "")
		postdelay = 2;
		
	else 
	{
		postdelay = getDvarFloat( "scr_killcam_posttime");
		if (postdelay < 0.05)
			postdelay = 0.05;
	}
	
	return postdelay;
}
addKillcamKiller(attacker,victim)
{
	self.villain = createFontString( "default", level.lowerTextFontSize );
	self.villain setPoint( "CENTER", "BOTTOM", -500, -110 ); 
	self.villain.alignX = "right";
	self.villain.archived = false;
	self.villain setPlayerNameString( attacker );
	self.villain.alpha = 1;
	self.villain.glowalpha = 1;
	self.villain.glowColor = level.randomcolour;
	self.villain moveOverTime( 4 );
	self.villain.x = -20;  

	self.versus = createFontString( "default", level.lowerTextFontSize );
	self.versus.alpha = 0;
	self.versus setPoint( "CENTER", "BOTTOM", 0, -110 );  
	self.versus.archived = false;
	self.versus setText( "vs" );
	self.versus.glowColor = (192,192,192);
	self.versus fadeOverTime( 4 );
	self.versus.alpha = 1;
  
	self.victim = createFontString( "default", level.lowerTextFontSize );
	self.victim setPoint( "CENTER", "BOTTOM", 500, -110 );
	self.victim.alignX = "left";  
	self.victim.archived = false;
	self.victim setPlayerNameString( victim );
	self.victim.glowalpha = 1; 
	self.victim.glowColor = (192,192,192);
	self.victim moveOverTime( 4 );
	self.victim.x = 20; 
	
	if ( isDefined( self.carryIcon ) )
		self.carryIcon destroy();
}
addKillcamTimer(camtime)
{
	if (! isDefined(self.fkc_timer))
	{
			self.fkc_timer = createFontString("big", 2.0);
			self.fkc_timer.archived = false;
			self.fkc_timer.x = 0;
			self.fkc_timer.alignX = "center";
			self.fkc_timer.alignY = "middle";
			self.fkc_timer.horzAlign = "center_safearea";
			self.fkc_timer.vertAlign = "top";
			self.fkc_timer.y = 50;
			self.fkc_timer.sort = 1;
			self.fkc_timer.font = "big";
			self.fkc_timer.foreground = true;
			self.fkc_timer.color = (0.85,0.85,0.85);
			self.fkc_timer.hideWhenInMenu = true;
	}
	self.fkc_timer.y = 50;
	self.fkc_timer.alpha = 1;
	self.fkc_timer setTenthsTimer(camtime);
}
setKillCamEntity( killcamentityindex, delayms )
{
	self endon("disconnect");
	self endon("end_killcam");
	self endon("spawned");
	
	if ( delayms > 0 )
		wait delayms / 1000;
	
	self.killcamentity = killcamentityindex;
}