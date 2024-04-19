
main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::SetupCallbacks();
	maps\mp\gametypes\_globallogic::SetupCallbacks();

	level.onStartGameType = ::onStartGameType;
	level.onSpawnPlayer = ::onSpawnPlayer;
}

onStartGameType()
{
	setClientNameMode("auto_change");

	maps\mp\gametypes\_globallogic::setObjectiveText( "allies", &"OBJECTIVES_DM" );
	maps\mp\gametypes\_globallogic::setObjectiveText( "axis", &"OBJECTIVES_DM" );

	maps\mp\gametypes\_globallogic::setObjectiveScoreText( "allies", &"OBJECTIVES_DM_SCORE" );
	maps\mp\gametypes\_globallogic::setObjectiveScoreText( "axis", &"OBJECTIVES_DM_SCORE" );

	maps\mp\gametypes\_globallogic::setObjectiveHintText( "allies", &"OBJECTIVES_DM_HINT" );
	maps\mp\gametypes\_globallogic::setObjectiveHintText( "axis", &"OBJECTIVES_DM_HINT" );

	level.spawnMins = ( 0, 0, 0 );
	level.spawnMaxs = ( 0, 0, 0 );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( "allies", "mp_dm_spawn" );
	maps\mp\gametypes\_spawnlogic::addSpawnPoints( "axis", "mp_dm_spawn" );
	level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
	setMapCenter( level.mapCenter );

	allowed[0] = "dm";
	maps\mp\gametypes\_gameobjects::main(allowed);

	level.displayRoundEndText = false;
	level.QuickMessageToAll = true;

	if ( level.roundLimit != 1 && level.numLives )
	{
		level.overridePlayerScore = true;
		level.displayRoundEndText = true;
		level.onEndGame = ::onEndGame;
	}
}

onSpawnPlayer()
{
	spawnPoints = maps\mp\gametypes\_spawnlogic::getTeamSpawnPoints( self.pers["team"] );
	spawnPoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_DM( spawnPoints );

	self spawn( spawnPoint.origin, spawnPoint.angles );
}

onEndGame( winningPlayer )
{
	if ( isDefined( winningPlayer ) )
		[[level._setPlayerScore]]( winningPlayer, winningPlayer [[level._getPlayerScore]]() + 1 );
}
