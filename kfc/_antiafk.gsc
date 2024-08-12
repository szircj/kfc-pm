// Made by szir for KFC Mod
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    // Register the AFKMonitor function when the level starts
    [[level.on]]("spawned", ::AFKMonitor);
}

AFKMonitor()
{
    // Events that end the monitoring
    level endon("vote started");
    self endon("disconnect");
    self endon("joined_spectators");
    self endon("game_ended");
    self endon("isKnifing");
    self endon("inintro");

    // Timer to track inactivity
    inactivityTimer = 0;

    while (isAlive(self))
    {
        // Store current position and angles
        previousPosition = self.origin;
        previousAngles = self.angles;

        wait 1;

        if (isAlive(self) && self.sessionteam != "spectator")
        {
            // Check if position or angles have changed
            if (self.origin == previousPosition && self.angles == previousAngles)
                inactivityTimer++;
            else
                inactivityTimer = 0;

            // Message if the player appears to be inactive
            if (inactivityTimer == 15)
                self iPrintlnBOld("^7You appear to be ^1AFK!");

            // Actions after 25 seconds of inactivity
            if (inactivityTimer >= 25)
            {
                if (self.sessionstate == "playing" && (!isDefined(self.isPlanting) || !self.isPlanting) && !level.gameEnded && isDefined(self.carryObject))
                {
                    self.carryObject thread maps\mp\gametypes\_gameobjects::setDropped();
                }

                // Change player's team to spectator and update state
                self.sessionteam = "spectator";
                self.sessionstate = "spectator";
                self [[level.spawnSpectator]]();
                
                // AFK notification
                iPrintln(self.name + " ^7appears to be ^1AFK!");
                return;
            }
        }
        else
        {
            // Reset timer if player is not in the game team
            inactivityTimer = 0;
        }
    }
}
