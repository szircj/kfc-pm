init()
{
    level thread players();
    //precacheShellShock( "tank_rumble" );
}

players()
{
    for(;;)
	{
		level waittill( "connected", player );
		if( !isdefined( player.pers["isbot"] ) )
        {
            player thread checkSprinting();
            player thread checkClipping();
            player thread checkLastDistance();
            //player thread randomFilmtweak();
            //player visualizeTriggers();
        }
				
	}
}

visualizeTriggers()
{
    for(;;){
        drawCircle( (5361, -2660, -30), 30, 50);
        wait 0.05;
    }
        
}



drawCircle(start, radius, height)
{
	points = [];
	r = radius;
	z = start[2];
	idx = 0;
	for(q = 0; q<2; q++)
	{
		h = start[0];
		k = start[1];
		for(i = 0; i< 360; i++)
		{
			x = h + r*Cos(i);
			y = k - r*Sin(i);
			points[idx] = (x,y,z);
			idx++;
		}
		z += height;
		for(i=0; i<points.size-1; i++)
		{
			drawLine(points[i], points[i+1], (1,0,0), true);
		}
	}
}
drawLine(start, end, colour, depth)
{
	
	line(start, end, colour, depth);
	
}

randomFilmtweak()
{
    self endon("disconnect");

    while (true)
    {
        // Generate a random float between 1.30 and 1.70
        randomContrast = randomfloatrange(1.40, 1.70);
        randomLightTint = randomVectorInRangeX(0, 1, 0.2);
        randomDarkTint = randomVectorInRangeX(0, 2, 0.2);
        randomDesaturation = randomfloatrange(0, 0.30);
        randomGamma = randomfloatrange(.50, 1.3);
        randomBrightness = randomfloatrange(.18, 0.50);

        iprintln(randomDarkTint);

        // Set the generated contrast value
        self setClientDvars(
            "r_filmtweakContrast", randomContrast,
            "r_filmtweakLightTint", randomLightTint,
            "r_filmtweakDarkTint", randomDarkTint,
            "r_filmtweakDesaturation", randomDesaturation,
            "r_filmtweakBrightness", randomBrightness,
            "r_gamma", randomGamma
        );

        // Print the generated contrast value (optional)
        iprintln("Random tweaks");

        // Delay for a period before generating another random value (e.g., 5 seconds)
        wait(1); // Adjust the delay as needed
    }
}

clamp(value, minValue, maxValue)
{
    if (value < minValue)
        return minValue;
    else if (value > maxValue)
        return maxValue;
    else
        return value;
}

randomVectorInRangeX(minValue, maxValue, bias)
{
    // Generate random value for randomR in the specified range
    randomR = randomfloatrange(minValue, maxValue);

    // Calculate the range for randomG and randomB based on randomR
    minG = clamp(randomR - bias, minValue, maxValue);
    maxG = clamp(randomR + bias, minValue, maxValue);

    // Generate random values for randomG and randomB within the calculated range
    randomG = randomfloatrange(minG, maxG);
    randomB = randomfloatrange(minG, maxG);

    return (randomR, randomG, randomB);
}

randomVectorInRange(minValue, maxValue)
{
    randomR = randomfloatrange(minValue, maxValue);
    randomG = randomfloatrange(minValue, maxValue);
    randomB = randomfloatrange(minValue, maxValue);
    
    return (randomR, randomG, randomB);
}

checkClipping()
{
    self endon("disconnect");

    crouchStartTime = 0;

    for (;;)
    {
        wait 0.05;
        if (self.sessionstate != "playing")
            continue;

        if (self getStance() == "stand")
        {
            if (crouchStartTime == 0)            
            {
                crouchStartTime = gettime();
                //iprintln("stand");
            }
            
        }
        else if( self getStance() == "crouch" && crouchStartTime != 0 && !self.sprinting && self isOnGround() )
        {   
            timeDiff = ( gettime() - crouchStartTime ) / 1000;
            if ( timeDiff <= 0.4 && isDefined( self.lastDistance ) && self.lastDistance < 50 )
            {
                // A clip was detected
                crouchStartTime = 0; // Reset the start time
                //self iPrintlnBold( "^1Clip detected^7 - " + self.name + ", time: " + timeDiff + ", distance: " + self.lastDistance );
                //visualizeTriggers();           
                if ( isDefined( game["PROMOD_MATCH_MODE"] ) && game["PROMOD_MATCH_MODE"] == "match" && level.gametype == "sd" && game["PROMOD_KNIFEROUND"] == 0 && level.fps_ac_check == 1 && level.fps_match_id != 0 && level.fps_track_stats == 1 )     
                {
                    self.pers["clips"]++;
                    thread promod\stats::clipReport( self, game["totalroundsplayed"]+1, timeDiff );
                }
                //self shellshock( "dog_bite", 2);               
            }
            else
            {            
                crouchStartTime = 0; // Reset the start time            
            }
        }
        else 
        {
            crouchStartTime = 0;        
        }
    }
}

checkLastDistance()
{
    self endon("disconnect");

    startTime = getTime();
    startPos = self.origin;
    distanceTraveled = 0;

    while (true)
    {
        currentPos = self.origin;
        elapsedTime = getTime() - startTime;

        if (elapsedTime >= 300)
        {
            // Calculate the distance traveled by the player
            distanceTraveled = distance(startPos, currentPos);

            // Reset the tracking
            startTime = getTime();
            startPos = currentPos;
        }

        self.lastDistance = distanceTraveled;
        //self iprintln("Distance Traveled: " + int( distanceTraveled ) );
        wait 0.2;
    }
}

applyFlash(duration, rumbleduration)
{
	if ( !isDefined( self.flashDuration ) || duration > self.flashDuration )
	{
		self notify ("strongerFlash");
	}


	wait 0.05;

	//self shellshock( "flashbang", 2);
	self.flashEndTime = getTime() + (2 * 1000);
	
    self shellshock( "dog_bite", 2);

	//self thread overlapProtect(duration);

	//self thread flashRumbleLoop( 5 );

}

flashRumbleLoop( duration )
{
	self endon("stop_monitoring_flash");

	self endon("flash_rumble_loop");
	self notify("flash_rumble_loop");

	goalTime = getTime() + duration * 1000;

	while ( getTime() < goalTime )
	{
		//self PlayRumbleOnEntity( "assault_fire" );
        iprintln("damage");
		wait 0.05;
	}
}

overlapProtect(duration)
{
	self endon( "disconnect" );
	self endon ( "strongerFlash" );
	for(;duration > 0;)
	{
		duration -= 0.05;
		self.flashDuration = duration;
		wait 0.05;
	}
}

isFlashbanged()
{
	return isDefined( self.flashEndTime ) && gettime() < self.flashEndTime;
}


checkSprinting()
{
    self endon("disconnect");
    self.sprinting = false;

    for (;;)
    {
        // Wait for the "sprint_begin" event
        self waittill("sprint_begin");
        self.sprinting = true;

        // The player has started sprinting
        //iPrintln("Player started sprinting");
        
        // Wait for the "sprint_end" event to detect when the player stops sprinting
        self waittill("sprint_end");
        self.sprinting = false;
        wait 1;       

        // The player has stopped sprinting

    }
}
