#include code\utility;
init()
{
	if( getDvar( "g_gametype" ) == "sd" )
		thread code\events::addSpawnEvent( ::onSpawn );
	else
		thread timedBalance();
}

onSpawn()
{
	level notify( "only_one_check" );
	level endon( "only_one_check" );
	
	wait 4;
	
	level.axisnum = 0;
	level.alliesnum = 0;
	
	wait .05;

	players = getPlayers();
	
	for( i=0; i<players.size; i++ )
	{
		if( players[i].team == "axis" )
			level.axisnum++;

		else if( players[i].team == "allies" )
			level.alliesnum++;
			
		waittillframeend;
	}
	
	wait .1;
	
	if( level.axisnum == level.alliesnum )
		return;

	else if( level.axisnum < level.alliesnum )
	{
		if( level.alliesnum - level.axisnum > 1 )
			thread balanceAxis( level.alliesnum - level.axisnum );
		else
			return;
	}

	else
	{
		if( level.axisnum - level.alliesnum > 1 )
			thread balanceAllies( level.axisnum - level.alliesnum );
		else
			return;
	}
	
	iprintlnbold( "Balancing teams..." );
}

timedBalance()
{
	level endon( "game_ended" );
	for(;;)
	{
		wait 30;
		thread onSpawn();  // Lazy xD
	}
}
//////////////////////////////////////////////////////////////////
// TODO:                                                        //
// This should be one function only with extra "Team" variable. //
//////////////////////////////////////////////////////////////////
balanceAxis( num )
{
	people = int( num/2 );
	
	players = getPlayers();
	magic = 0;
	pool = [];
	for( i=0; i<players.size; i++ )
	{
		if( players[i].team == "allies" )
		{
			pool[magic] = players[i];
			magic++;
		}
		waittillframeend;
	}
	
	for( p=0; p<people; p++ )
	{
		number = randomIntRange( 0, pool.size );
		
		if( pool[ number ].team == "allies" )
		{
			pool[ number ] suicide();
			pool[ number ] setTeam( "axis" );
			pool[ number ] thread maps\mp\gametypes\_globallogic::spawnPlayer();
		}
		else
		{
			if( p == 0 )
				continue;
			else
				p--;
		}
		waittillframeend;
	}
	
	wait .1;
	level notify( "only_one_check" );
}

balanceAllies( num )
{
	people = int( num/2 );
	
	players = getPlayers();
	magic = 0;
	pool = [];
	for( i=0; i<players.size; i++ )
	{
		if( players[i].team == "axis" )
		{
			pool[magic] = players[i];
			magic++;
		}
		waittillframeend;
	}
	
	for( p=0; p<people; p++ )
	{
		number = randomIntRange( 0, pool.size );
		
		if( isDefined( pool[ number ] ) && pool[ number ].team == "axis" )
		{
			pool[ number ] suicide();
			pool[ number ] setTeam( "allies" );
			pool[ number ] thread maps\mp\gametypes\_globallogic::spawnPlayer();
		}
		else
		{
			if( p == 0 )
				continue;
			else
				p--;
		}
		waittillframeend;
	}
	
	wait .1;
	level notify( "only_one_check" );
}