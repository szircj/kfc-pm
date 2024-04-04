main()
{
    // Requires CoD4X server and http plugin, so commented out
	thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);

        if( !isDefined(player.pers["onAnticheat"] ))
		    player thread monitorAC();
	}
}

onMatchIdChange()
{
    for ( i = 0; i < level.players.size; i++ )
	{
        player = level.players[i];
        player.pers["onAnticheat"] = undefined;

        if( !isDefined(player.pers["onAnticheat"] ))
            player thread monitorAC();
    }
}

monitorAC()
{
	self endon("ac_online");
    self endon("disconnect");

	for(;;)
	{
        self thread getAcStatus();
		wait 5;
	}
}

isOnAnticheat()
{
    if ( isDefined(self.pers["onAnticheat"]) && self.pers["onAnticheat"] )
        return true;
    else    
        return false;
}

setPlayerRank()
{
    if ( isOnAnticheat())
        self setRank(6, 0);
    else 
        self setRank(0, 1);
}

getAcStatus()
{
    //x = http_get_x("http://127.0.0.1:8000/api/test");
    //iprintln(x);
    //ip = self get_ip();
    //iprintln(ip);
    // Requires CoD4X server and http plugin, so logic hidden
    iprintln("Getting AC Status for match " + level.fps_match_id);
    wait 1;
    iprintln("AC Online");
    self.pers["onAnticheat"] = true;
    self notify("ac_online");
   
    entityNumber = self getEntityNumber();

    if (entityNumber % 2 == 0)
    {
        // Entity number is even, assign teamId for even case
        self.pers["teamId"] = 1; // Replace with the actual teamId value
    }
    else
    {
        // Entity number is odd, assign teamId for odd case
        self.pers["teamId"] = 2; // Replace with the actual teamId value
    }
}

callback(handle)
{
    iprintln(handle);
    // Requires CoD4X server and http plugin, so logic hidden
}


