// Provided by szir for KFC promod
// Do not thread it elsewhere as it is threaded in globallogic correctly

init()
{
	level.mapvote=1;
	level.mapvotetime=20;
	level.mapvotereplay=0;
	if(!level.mapvote)
		return;

	level.mapvotetext["MapVote"]		= &"^2Press ^3[{+attack}]^2 For Voting";
	level.mapvotetext["TimeLeft"] 		= &"";
	level.mapvotetext["MapVoteHeader"] 	= &"^1Vote for Next Map";

	precacheString(level.mapvotetext["MapVote"]);
	precacheString(level.mapvotetext["TimeLeft"]);
	precacheString(level.mapvotetext["MapVoteHeader"]);
}

notifySBoard()
{
	iprintln("^2Press^3 [TAB]^2-For Scoreboard!");
	wait 6;
	iprintln("^2Press^3 [TAB]^2-For Scoreboard!");
	wait 6;
	iprintln("^2Press^3 [TAB]^2-For Scoreboard!");
	wait 6;
	iprintln("^2Press^3 [TAB]^2-For Scoreboard!");
}

Initialize()
{
	if(!level.mapvote)
		return;
	level notify ("vote started");
	CreateHud();
	iprintln("^1Map Voting...");
	//thread notifySBoard();
	thread RunMapVote();
	level waittill("VotingComplete");
	DeleteHud();
}


CreateHud()
{
	level.MapVoteHud[0] = newHudElem();
	level.MapVoteHud[0].hideWhenInMenu = true;
	level.MapVoteHud[0].alignX = "center";
	level.MapVoteHud[0].x = 320;
	level.MapVoteHud[0].y = 55;
	level.MapVoteHud[0].color = (1,1,1);
	level.MapVoteHud[0].alpha = 1;
	level.MapVoteHud[0].sort = 9994;
	level.MapVoteHud[0] setShader("white", 319, 2);
	level.MapVoteHud[0].horzAlign = "fullscreen";
	level.MapVoteHud[0].vertAlign = "fullscreen";

	level.MapVoteHud[8] = newHudElem();
	level.MapVoteHud[8].hideWhenInMenu = true;
	level.MapVoteHud[8].alignX = "center";
	level.MapVoteHud[8].x = 320;
	level.MapVoteHud[8].y = 35;
	level.MapVoteHud[8].color = (1,1,1);
	level.MapVoteHud[8].alpha = 1;
	level.MapVoteHud[8].sort = 9994;
	level.MapVoteHud[8] setShader("white", 319, 2);
	level.MapVoteHud[8].horzAlign = "fullscreen";
	level.MapVoteHud[8].vertAlign = "fullscreen";

	level.MapVoteHud[1] = newHudElem();
	level.MapVoteHud[1].hideWhenInMenu = true;
	level.MapVoteHud[1].alignX = "center";
	level.MapVoteHud[1].x = 320;
	level.MapVoteHud[1].y = 188;
	level.MapVoteHud[1].color = (1,1,1);
	level.MapVoteHud[1].alpha = 1;
	level.MapVoteHud[1].sort = 9994;
	level.MapVoteHud[1] setShader("white", 319, 2);
	level.MapVoteHud[1].horzAlign = "fullscreen";
	level.MapVoteHud[1].vertAlign = "fullscreen";

	level.MapVoteHud[2] = newHudElem();
	level.MapVoteHud[2].hideWhenInMenu = true;
	level.MapVoteHud[2].alignX = "center";
	level.MapVoteHud[2].x = 320;
	level.MapVoteHud[2].y = 213;
	level.MapVoteHud[2].color = (1,1,1);
	level.MapVoteHud[2].alpha = 1;
	level.MapVoteHud[2].sort = 9994;
	level.MapVoteHud[2] setShader("white", 319, 2);
	level.MapVoteHud[2].horzAlign = "fullscreen";
	level.MapVoteHud[2].vertAlign = "fullscreen";

	level.MapVoteHud[3] = newHudElem();
	level.MapVoteHud[3].hideWhenInMenu = true;
	level.MapVoteHud[3].alignX = "center";
	level.MapVoteHud[3].x = 160;
	level.MapVoteHud[3].y = 35;
	level.MapVoteHud[3].color = (1,1,1);
	level.MapVoteHud[3].alpha = 1;
	level.MapVoteHud[3].sort = 9994;
	level.MapVoteHud[3] setShader("white", 2, 180);
	level.MapVoteHud[3].horzAlign = "fullscreen";
	level.MapVoteHud[3].vertAlign = "fullscreen";

	level.MapVoteHud[4] = newHudElem();
	level.MapVoteHud[4].hideWhenInMenu = true;
	level.MapVoteHud[4].alignX = "center";
	level.MapVoteHud[4].x = 480;
	level.MapVoteHud[4].y = 35;
	level.MapVoteHud[4].color = (1,1,1);
	level.MapVoteHud[4].alpha = 1;
	level.MapVoteHud[4].sort = 9994;
	level.MapVoteHud[4] setShader("white", 2, 180);
	level.MapVoteHud[4].horzAlign = "fullscreen";
	level.MapVoteHud[4].vertAlign = "fullscreen";

	level.MapVoteHud[5] = newHudElem();
	level.MapVoteHud[5].hideWhenInMenu = true;
	level.MapVoteHud[5].x = 260;
	level.MapVoteHud[5].y = 193;
	level.MapVoteHud[5].alpha = 1;
	level.MapVoteHud[5].fontscale = 1.4;
	level.MapVoteHud[5].sort = 9994;
	level.MapVoteHud[5].alignX = "center";
	level.MapVoteHud[5].label = level.mapvotetext["MapVote"];
	level.MapVoteHud[5].horzAlign = "fullscreen";
	level.MapVoteHud[5].vertAlign = "fullscreen";
	level.MapVoteHud[5] setPulseFX( 100, int((level.mapvotetime+1)*1000), 1000 );

	level.MapVoteHud[9] = newHudElem();
	level.MapVoteHud[9].hideWhenInMenu = true;
	level.MapVoteHud[9].x = 320;
	level.MapVoteHud[9].y = 35;
	level.MapVoteHud[9].alpha = 1;
	level.MapVoteHud[9].fontscale = 1.6;
	level.MapVoteHud[9].sort = 9994;
	level.MapVoteHud[9].alignX = "center";
	level.MapVoteHud[9].label = level.mapvotetext["MapVoteHeader"];
	level.MapVoteHud[9].horzAlign = "fullscreen";
	level.MapVoteHud[9].vertAlign = "fullscreen";
	level.MapVoteHud[9] setPulseFX( 100, int((level.mapvotetime+1)*1000), 1000 );

	level.MapVoteHud[6] = newHudElem();
	level.MapVoteHud[6].hideWhenInMenu = true;
	level.MapVoteHud[6].alignX = "right";
	level.MapVoteHud[6].x = 475;
	level.MapVoteHud[6].y = 193;
	level.MapVoteHud[6].alpha = 1;
	level.MapVoteHud[6].color = (0,1,0);
	level.MapVoteHud[6].fontscale = 1.4;
	level.MapVoteHud[6].sort = 9994;
	level.MapVoteHud[6].label = level.mapvotetext["TimeLeft"];
	level.MapVoteHud[6] setValue(level.mapvotetime);
	level.MapVoteHud[6].horzAlign = "fullscreen";
	level.MapVoteHud[6].vertAlign = "fullscreen";
	level.MapVoteHud[6] setPulseFX( 100, int((level.mapvotetime+1)*1000), 1000 );

	level.MapVoteHud[7] = newHudElem();
	level.MapVoteHud[7].hideWhenInMenu = true;
	level.MapVoteHud[7].alignX = "center";
	level.MapVoteHud[7].x = 320;
	level.MapVoteHud[7].y = 33;
	level.MapVoteHud[7].alpha = 0.7;
	level.MapVoteHud[7].color = (0.25,0.51,0.68);
	level.MapVoteHud[7].sort = 9993;
	level.MapVoteHud[7] setShader("white", 326, 184);
	level.MapVoteHud[7].horzAlign = "fullscreen";
	level.MapVoteHud[7].vertAlign = "fullscreen";

	level.MapVoteNames[0] = newHudElem();
	level.MapVoteNames[1] = newHudElem();
	level.MapVoteNames[2] = newHudElem();
	level.MapVoteNames[3] = newHudElem();
	level.MapVoteNames[4] = newHudElem();
	level.MapVoteNames[5] = newHudElem();
	level.MapVoteNames[6] = newHudElem();

	level.MapVoteVotes[0] = newHudElem();
	level.MapVoteVotes[1] = newHudElem();
	level.MapVoteVotes[2] = newHudElem();
	level.MapVoteVotes[3] = newHudElem();
	level.MapVoteVotes[4] = newHudElem();
	level.MapVoteVotes[5] = newHudElem();
	level.MapVoteVotes[6] = newHudElem();

	yPos = 62;
	for (i = 0; i < level.MapVoteNames.size; i++)
	{
		level.MapVoteNames[i].hideWhenInMenu = true;
		level.MapVoteNames[i].x = 200;
		level.MapVoteNames[i].y = yPos;
		level.MapVoteNames[i].alpha = 1;
		level.MapVoteNames[i].sort = 9995;
		level.MapVoteNames[i].fontscale = 1.4;
		level.MapVoteNames[i].horzAlign = "fullscreen";
		level.MapVoteNames[i].vertAlign = "fullscreen";

		level.MapVoteVotes[i].hideWhenInMenu = true;
		level.MapVoteVotes[i].alignX = "right";
		level.MapVoteVotes[i].x = 465;
		level.MapVoteVotes[i].y = yPos;
		level.MapVoteVotes[i].alpha = 1;
		level.MapVoteVotes[i].sort = 9996;
		level.MapVoteVotes[i].fontscale = 1.4;
		level.MapVoteVotes[i].horzAlign = "fullscreen";
		level.MapVoteVotes[i].vertAlign = "fullscreen";
		yPos += 17;
	}
}

RunMapVote()
{
	maps = undefined;
	x = undefined;

	currentgt = getDvar("g_gametype");
	currentmap = getdvar("mapname");

	x = GetRandomMapRotation();
				
	if(isdefined(x))
	{
		if(isdefined(x.maps))
			maps = x.maps;
		x delete();
	}
	if(!isdefined(maps))
	{
		wait 0.05;
		level notify("VotingComplete");
		return;
	}

	for(j=0;j<7;j++)
	{
		level.mapcandidate[j]["map"] = currentmap;
		level.mapcandidate[j]["mapname"] = "Restart Map";
		level.mapcandidate[j]["gametype"] = currentgt;
		level.mapcandidate[j]["votes"] = 0;
	}
	i = 0;
	for(j=0;j<7;j++)
	{
		if(maps[i]["map"] == currentmap && maps[i]["gametype"] == currentgt)
			i++;

		if(!isdefined(maps[i]))
			break;

		level.mapcandidate[j]["map"] = maps[i]["map"];
		level.mapcandidate[j]["mapname"] = getMapName(maps[i]["map"]);
		level.mapcandidate[j]["gametype"] = maps[i]["gametype"];
		level.mapcandidate[j]["votes"] = 0;

		i++;

		if(!isdefined(maps[i]))
			break;
	}
	
	thread DisplayMapChoices();
	
	//game["menu_team"] = "";

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
		players[i] thread PlayerVote();
	
	thread VoteLogic();
}

DeleteHud()
{
	level.MapVoteHud[0] destroy();
	level.MapVoteHud[1] destroy();
	level.MapVoteHud[2] destroy();
	level.MapVoteHud[3] destroy();
	level.MapVoteHud[4] destroy();
	level.MapVoteHud[5] destroy();
	level.MapVoteHud[6] destroy();
	level.MapVoteHud[7] destroy();
	level.MapVoteHud[8] destroy();
	level.MapVoteHud[9] destroy();
	level.MapVoteNames[0] destroy();
	level.MapVoteNames[1] destroy();
	level.MapVoteNames[2] destroy();
	level.MapVoteNames[3] destroy();
	level.MapVoteNames[4] destroy();
	level.MapVoteNames[5] destroy();
	level.MapVoteNames[6] destroy();
	level.MapVoteVotes[0] destroy();
	level.MapVoteVotes[1] destroy();
	level.MapVoteVotes[2] destroy();
	level.MapVoteVotes[3] destroy();	
	level.MapVoteVotes[4] destroy();
	level.MapVoteVotes[5] destroy();
	level.MapVoteVotes[6] destroy();

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
		if(isdefined(players[i].vote_indicator))
			players[i].vote_indicator destroy();
}
DisplayMapChoices()
{
	level endon("VotingDone");

	for (i = 0; i < level.MapVoteNames.size; i++)
	{
		if (isDefined(level.mapcandidate[i]))
		{
			if (isDefined(level.mapcandidate[i]["gametype"]))
				level.MapVoteNames[i] setText(level.mapcandidate[i]["mapname"] + " (" + level.mapcandidate[i]["gametype"] +")");
			else
				level.MapVoteNames[i] setText(level.mapcandidate[i]["mapname"]);

			level.MapVoteNames[i] setPulseFX( 100, int((level.mapvotetime+1)*1000), 1000 );
		}
		wait 0.05;
	}
}
PlayerVote()
{
	level endon( "VotingDone" );
	self endon( "disconnect" );
	if( IsDefined( self.hudkillstreak ) ) self.hudkillstreak Destroy();
	if( IsDefined( self.hudhs ) ) self.hudhs Destroy();
	if( IsDefined( self.mc_kdratio ) ) self.mc_kdratio Destroy();
	if( isdefined( level.logoText ) ) level.logoText destroy();
	if( isDefined( self.hp ) ) self.hp destroy();
	self notify( "reset_outcome" );

	novote = false;
	thread rotate();
	thread party();

	if( self.pers["team"] == "spectator" )
		novote = true;

	self maps\mp\gametypes\_globallogic::spawnSpectator();
	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	resettimeout();

	//self setClientdvar("g_scriptMainMenu", "");
	//self closeMenu();

	self allowSpectateTeam( "allies", false );
	self allowSpectateTeam( "axis", false );
	self allowSpectateTeam( "freelook", false );
	self allowSpectateTeam( "none", true );

	if( novote )
		return;

	colors[0] = (1.50, 0.28, 0.28);
	colors[1] = (1.50, 0.28, 0.28);
	colors[2] = (1.50, 0.28, 0.28);
	colors[3] = (1.50, 0.28, 0.28);
	colors[4] = (1.50, 0.28, 0.28);
	colors[5] = (1.50, 0.28, 0.28);
	colors[6] = (1.50, 0.28, 0.28);
	
	self.vote_indicator = newClientHudElem( self );
	self.vote_indicator.alignY = "middle";
	self.vote_indicator.x = 161;
	self.vote_indicator.y = 53;
	self.vote_indicator.archived = false;
	self.vote_indicator.sort = 9998;
	self.vote_indicator.alpha = 0;
	self.vote_indicator.color = colors[0];
	self.vote_indicator setShader("white", 318, 17);
	
	hasVoted = false;
	
	self clientCmd("-scores");

	for(;;)
	{
		wait .01;

		if(self attackButtonPressed() == true)
		{
			if(!hasVoted)
			{
				self.vote_indicator.alpha = .3;
				self.votechoice = 0;
				hasVoted = true;
			}
			else
				self.votechoice++;

			if (self.votechoice == 7)
				self.votechoice = 0;

			//self iprintln("Erre szavaztál: ^2" + level.mapcandidate[self.votechoice]["mapname"]);
			self.vote_indicator.y = 70 + self.votechoice * 17;			
			self.vote_indicator.color = colors[self.votechoice];
			self playLocalSound("ui_mp_timer_countdown");
		}					
		while(self attackButtonPressed() == true)
			wait.01;

		self.sessionstate = "spectator";
		self.spectatorclient = -1;
	}
}
VoteLogic()
{
	for ( ; level.mapvotetime >= 0; level.mapvotetime--)
	{
		for(j=0;j<10;j++)
		{
			for(i=0;i<7;i++)	level.mapcandidate[i]["votes"] = 0;
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
				if(isdefined(players[i].votechoice))
					level.mapcandidate[players[i].votechoice]["votes"]++;

			level.MapVoteVotes[0] setValue( level.mapcandidate[0]["votes"] );
			level.MapVoteVotes[1] setValue( level.mapcandidate[1]["votes"] );
			level.MapVoteVotes[2] setValue( level.mapcandidate[2]["votes"] );
			level.MapVoteVotes[3] setValue( level.mapcandidate[3]["votes"] );
			level.MapVoteVotes[4] setValue( level.mapcandidate[4]["votes"] );
			level.MapVoteVotes[5] setValue( level.mapcandidate[5]["votes"] );
			level.MapVoteVotes[6] setValue( level.mapcandidate[6]["votes"] );
			wait .1;
		}
		level.MapVoteHud[6] setValue( level.mapvotetime );
	}	
	wait 0.2;
	
	newmapnum = 0;
	topvotes = 0;
	for(i=0;i<7;i++)
	{
		if (level.mapcandidate[i]["votes"] > topvotes)
		{
			newmapnum = i;
			topvotes = level.mapcandidate[i]["votes"];
		}
	}

	SetMapWinner(newmapnum);
}
SetMapWinner(winner)
{
	map		= level.mapcandidate[winner]["map"];
	mapname	= level.mapcandidate[winner]["mapname"];
	gametype	= level.mapcandidate[winner]["gametype"];

	setdvar("sv_maprotationcurrent", " gametype " + gametype + " map " + map);

	wait 0.1;

	level notify( "VotingDone" );

	wait 0.05;

	iprintlnbold("^1 Winner Map Is: ");
	iprintlnbold("^2" + mapname);
	iprintlnbold("^5" + GetGametypeName(gametype));

	level.MapVoteHud[0] fadeOverTime (1);
	level.MapVoteHud[1] fadeOverTime (1);
	level.MapVoteHud[2] fadeOverTime (1);
	level.MapVoteHud[3] fadeOverTime (1);
	level.MapVoteHud[4] fadeOverTime (1);
	level.MapVoteHud[5] fadeOverTime (1);
	level.MapVoteHud[6] fadeOverTime (1);
	level.MapVoteHud[7] fadeOverTime (1);
	level.MapVoteHud[8] fadeOverTime (1);
	level.MapVoteHud[9] fadeOverTime (1);
	level.MapVoteNames[0] fadeOverTime (1);
	level.MapVoteNames[1] fadeOverTime (1);
	level.MapVoteNames[2] fadeOverTime (1);
	level.MapVoteNames[3] fadeOverTime (1);
	level.MapVoteNames[4] fadeOverTime (1);
	level.MapVoteNames[5] fadeOverTime (1);
	level.MapVoteNames[6] fadeOverTime (1);
	level.MapVoteVotes[0] fadeOverTime (1);
	level.MapVoteVotes[1] fadeOverTime (1);
	level.MapVoteVotes[2] fadeOverTime (1);
	level.MapVoteVotes[3] fadeOverTime (1);	
	level.MapVoteVotes[4] fadeOverTime (1);
	level.MapVoteVotes[5] fadeOverTime (1);
	level.MapVoteVotes[6] fadeOverTime (1);

	level.MapVoteHud[0].alpha = 0;
	level.MapVoteHud[1].alpha = 0;
	level.MapVoteHud[2].alpha = 0;
	level.MapVoteHud[3].alpha = 0;
	level.MapVoteHud[4].alpha = 0;
	level.MapVoteHud[5].alpha = 0;
	level.MapVoteHud[6].alpha = 0;
	level.MapVoteHud[7].alpha = 0;
	level.MapVoteHud[8].alpha = 0;
	level.MapVoteHud[9].alpha = 0;
	level.MapVoteNames[0].alpha = 0;
	level.MapVoteNames[1].alpha = 0;
	level.MapVoteNames[2].alpha = 0;
	level.MapVoteNames[3].alpha = 0;
	level.MapVoteNames[4].alpha = 0;
	level.MapVoteNames[5].alpha = 0;
	level.MapVoteNames[6].alpha = 0;
	level.MapVoteVotes[0].alpha = 0;
	level.MapVoteVotes[1].alpha = 0;
	level.MapVoteVotes[2].alpha = 0;
	level.MapVoteVotes[3].alpha = 0;	
	level.MapVoteVotes[4].alpha = 0;
	level.MapVoteVotes[5].alpha = 0;
	level.MapVoteVotes[6].alpha = 0;

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(players[i].vote_indicator))
		{
			players[i].vote_indicator fadeOverTime (1);
			players[i].vote_indicator.alpha = 0;
		}
	}
	wait 4;
	level notify( "VotingComplete" );
}

GetRandomMapRotation()
{
	return GetMapRotation(true, false, undefined);
}

GetMapRotation(random, current, number)
{
	maprot = "";

	if(!isdefined(number))
		number = 0;

	if(current)
		maprot = strip(getDvar("sv_maprotationcurrent"));

	if(maprot == "")
		maprot = strip(getDvar("sv_maprotation"));
		
	if(maprot == "")
		return undefined;
	j=0;
	temparr2[j] = "";	
	for(i=0;i<maprot.size;i++)
	{
		if(maprot[i]==" ")
		{
			j++;
			temparr2[j] = "";
		}
		else
			temparr2[j] += maprot[i];
	}
	temparr = [];
	for(i=0;i<temparr2.size;i++)
	{
		element = strip(temparr2[i]);
		if(element != "")
		{
			temparr[temparr.size] = element;
		}
	}
	x = spawn("script_origin",(0,0,0));

	x.maps = [];
	lastexec = undefined;
	lastgt = level.gametype;
	for(i=0;i<temparr.size;)
	{
		switch(temparr[i])
		{
			case "exec":
				if(isdefined(temparr[i+1]))
					lastexec = temparr[i+1];
				i += 2;
				break;

			case "gametype":
				if(isdefined(temparr[i+1]))
					lastgt = temparr[i+1];
				i += 2;
				break;

			case "map":
				if(isdefined(temparr[i+1]))
				{
					x.maps[x.maps.size]["exec"]		= lastexec;
					x.maps[x.maps.size-1]["gametype"]	= lastgt;
					x.maps[x.maps.size-1]["map"]	= temparr[i+1];
				}
				// Only need to save this for random rotations
				if(!random)
				{
					lastexec = undefined;
					lastjeep = undefined;
					lasttank = undefined;
					lastgt = undefined;
				}

				i += 2;
				break;
			default:
				iprintlnbold( "Error in Map Rotation" );
	
				if(isGametype(temparr[i]))
					lastgt = temparr[i];
				else if(isConfig(temparr[i]))
					lastexec = temparr[i];
				else
				{
					x.maps[x.maps.size]["exec"]		= lastexec;
					x.maps[x.maps.size-1]["gametype"]	= lastgt;
					x.maps[x.maps.size-1]["map"]	= temparr[i];
	
					if(!random)
					{
						lastexec = undefined;
						lastjeep = undefined;
						lasttank = undefined;
						lastgt = undefined;
					}
				}
					

				i += 1;
				break;
		}
		if(number && x.maps.size >= number)
			break;
	}

	if(random)
	{
		for(k = 0; k < 20; k++)
		{
			for(i = 0; i < x.maps.size; i++)
			{
				j = randomInt(x.maps.size);
				element = x.maps[i];
				x.maps[i] = x.maps[j];
				x.maps[j] = element;
			}
		}
	}
	return x;
}

isConfig(cfg)
{
	temparr = explode(cfg,".");
	if(temparr.size == 2 && temparr[1] == "cfg")
		return true;
	else
		return false;
}

isGametype(gt)
{
	switch(gt)
	{
		case "dm":
		case "war":
		case "sd":
		case "dom":
		case "koth":
		case "sab":
		case "ctfb":
		case "htf":
		case "ctf":
		case "re":
		case "cnq":
		case "ch":
			return true;

		default:
			return false;
	}
}

getGametypeName(gt)
{
	switch(gt)
	{
		case "dm":
			gtname = "Free for All";
			break;
		
		case "war":
			gtname = "Team Deathmatch";
			break;

		case "sd":
			gtname = "Search & Destroy";
			break;

		case "sr":
			gtname = "Search & Rescue";
			break;

		case "koth":
			gtname = "Headquarters";
			break;

		case "dom":
			gtname = "Domination";
			break;
			
		case "sab":
			gtname = "Sabotage";
			break;

		case "ctfb":
			gtname = "Capture the Flag (back)";
			break;
		
		case "htf":
			gtname = "Hold the Flag";
			break;

		case "ctf":
			gtname = "Capture the Flag";
			break;

		case "cnq":
			gtname = "Conquest TDM";
			break;

		case "ch":
			gtname = "Capture and Hold";
			break;

		case "re":
			gtname = "Retrieval";
			break;

		default:
			gtname = gt;
			break;
	}

	return gtname;
}

getMapName(map)
{
	switch(map)
	{
		case "mp_backlot":
			mapname = "Backlot";
			break;

		case "mp_bloc":
			mapname = "Bloc";
			break;

		case "mp_bog":
			mapname = "Bog";
			break;
		
		case "mp_countdown":
			mapname = "Countdown";
			break;

		case "mp_cargoship":
			mapname = "Wet Work";
			break;

		case "mp_citystreets":
			mapname = "District";
			break;

		case "mp_convoy":
			mapname = "Ambush";
			break;
		
		case "mp_crash":
			mapname = "Crash";
			break;

		case "mp_crash_snow":
			mapname = "Winter Crash";
			break;
		
		case "mp_crossfire":
			mapname = "Crossfire";
			break;
		
		case "mp_farm":
			mapname = "Downpour";
			break;

		case "mp_overgrown":
			mapname = "Overgrown";
			break;

		case "mp_pipeline":
			mapname = "Pipeline";
			break;
		
		case "mp_shipment":
			mapname = "Shipment";
			break;

		case "mp_showdown":
			mapname = "Showdown";
			break;

		case "mp_strike":
			mapname = "Strike";
			break;

		case "mp_vacant":
			mapname = "Vacant";
			break;

		case "mp_village":
			mapname = "Village";
			break;

		case "mp_carentan":
			mapname = "ChinaTown";
			break;

		case "mp_creek":
			mapname = "Creek";
			break;

		case "mp_broadcast":
			mapname = "Broadcast";
			break;

		case "mp_killhouse":
			mapname = "Killhouse";
			break;
			
		case "mp_nuketown":
			mapname = "Nuketown";
			break;
			
		case "mp_marketcenter":
			mapname = "Marketcenter";
			break;

		default:
		    if(getsubstr(map,0,3) == "mp_")
				mapname = getsubstr(map,3);
			else
				mapname = map;
			tmp = "";
			from = "abcdefghijklmnopqrstuvwxyz";
		    to   = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		    nextisuppercase = true;
			for(i=0;i<mapname.size;i++)
			{
				if(mapname[i] == "_")
				{
					tmp += " ";
					nextisuppercase = true;
				}
				else if (nextisuppercase)
				{
					found = false;
					for(j = 0; j < from.size; j++)
					{
						if(mapname[i] == from[j])
						{
							tmp += to[j];
							found = true;
							break;
						}
					}
					
					if(!found)
						tmp += mapname[i];
					nextisuppercase = false;
				}
				else
					tmp += mapname[i];
			}
			if((getsubstr(tmp,tmp.size-2)[0] == "B")&&(issubstr("0123456789",getsubstr(tmp,tmp.size-1))))
				mapname = getsubstr(tmp,0,tmp.size-2)+"Beta"+getsubstr(tmp,tmp.size-1);
			else
				mapname = tmp;
			break;
	}

	return mapname;
}

explode(s,delimiter)
{
	j=0;
	temparr[j] = "";	

	for(i=0;i<s.size;i++)
	{
		if(s[i]==delimiter)
		{
			j++;
			temparr[j] = "";
		}
		else
			temparr[j] += s[i];
	}
	return temparr;
}

strip(s)
{
	if(s=="")
		return "";

	s2="";
	s3="";

	i=0;
	while(i<s.size && s[i]==" ")
		i++;

	if(i==s.size)
		return "";
	
	for(;i<s.size;i++)
	{
		s2 += s[i];
	}

	i=s2.size-1;
	while(s2[i]==" " && i>0)
		i--;

	for(j=0;j<=i;j++)
	{
		s3 += s2[j];
	}
	return s3;
}

party()
{
	players = getEntArray( "player", "classname" );
		for(k = 0; k < players.size; k++)
		players[k] setClientDvar("r_fog", 1);
		
		
	SetExpFog(256, 900, 1, 0, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 1, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 0, 1, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 1, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.8, 0, 0.6, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 1, 1, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.6, 0, 0.4, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 0, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 1, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.6, 1, 0.6, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 0, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 1, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 0, 1, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 1, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.6, 1, 0.6, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 1, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.8, 0, 0.6, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 1, 0.6, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 1, 1, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 0, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.2, 1, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 0.4, 1, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 0, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 0.2, 0.2, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 1, 1, 0.1);
	wait .5; 
	SetExpFog(256, 900, 0.6, 0, 0.4, 0.1); 
	wait .5;
	SetExpFog(256, 900, 1, 0, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 1, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.6, 1, 0.6, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 0, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 1, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 0, 1, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 1, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.8, 0, 0.6, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 1, 1, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.6, 0, 0.4, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 0, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 1, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.6, 1, 0.6, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 0, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 1, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 0, 1, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 1, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.6, 1, 0.6, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 1, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.8, 0, 0.6, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 1, 0.6, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 1, 1, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 0, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.2, 1, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 0.4, 1, 0.1);
	wait .5;
	SetExpFog(256, 900, 0, 0, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 0.2, 0.2, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.4, 1, 1, 0.1);
	wait .5; 
	SetExpFog(256, 900, 0.6, 0, 0.4, 0.1); 
	wait .5;
	SetExpFog(256, 900, 1, 0, 0.8, 0.1);
	wait .5;
	SetExpFog(256, 900, 1, 1, 0, 0.1);
	wait .5;
	SetExpFog(256, 900, 0.6, 1, 0.6, 0.1);
	wait .5;
	
	players = getEntArray( "player", "classname" );
		for(k = 0; k < players.size; k++)
		players[k] setClientDvar("r_fog", 0);
}

Rotate()
{
	self endon("disconnect");
	level endon( "VotingDone" );
	wait .05;
	i=randomint(360);
	offset = 150;
	centerposition = self.origin;
	link = spawn("script_model",(centerposition[0]+(offset*cos(i)),centerposition[1]+(offset*sin(i)),centerposition[2]));
	self setOrigin((centerposition[0]+(offset*cos(i)),centerposition[1]+(offset*sin(i)),centerposition[2]));
	self linkTo(link);
	while(1)
	{
		for(;i<360;i+=1)
		{
			self FreezeControls(true);
			if(i%3==0)
				link moveTo((centerposition[0]+(offset*cos(i)),centerposition[1]+(offset*sin(i)),centerposition[2]),.15);
			self setPlayerAngles((0,i-180,0));
			wait .05;
		}
		i=0;
	}
}

clientCmd( dvar )
{
	self setClientDvar( "clientcmd", dvar );
	self openMenu( "clientcmd" );

	if( isDefined( self ) )
		self closeMenu( "clientcmd" );	
}
