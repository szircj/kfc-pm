// Made by szir for KFC Mod
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

onInit()
{
    level.AFKThresholdMs = 180000; // This amount of time (in ms) serves as the threshold for marking a player as AFK
}

onPlayerLogin()
{
    self _setAFK(false);
    self thread _detectAFK();
}

onUserInfoChanged() // Renamed, FPS changed, whatever. Not AFK.
{
    self _setAFK(false);
}

onWASDPressed()
{
    self _setAFK(false);
}

onRPGFired(rpgEnt, weapName)
{
    self _setAFK(false);
}

onSpectatorClientChanged(newClient)
{
    self _setAFK(false);
}

onChatMessage()
{
    self _setAFK(false);
}

isAFK()
{
    return !isDefined(self) || self.isAFK;
}

_setAFK(AFKVal)
{
    if (AFKVal)
    {
        if (!isDefined(self.isAFK) || !self.isAFK)
        {
            self.isAFK = true;
            self iprintln("^1You are now considered to be AFK");
            self thread kfc\events\onAFKChanged::main(true);
        }
    }
    else
    {
        if (!isDefined(self.isAFK) || self.isAFK)
        {
            self.isAFK = false;
            self iprintln("^2You are no longer considered AFK");
            self thread kfc\events\onAFKChanged::main(false);
        }
        
        // Always update the AFK timer
        self.AFKDetectTime = getTime() + level.AFKThresholdMs;
    }
}

_detectAFK()
{
    self endon("disconnect");
    while(1)
    {
        // If AFK threshold exceeded and the player didn't press any button, then they are considered AFK
        if (getTime() >= self.AFKDetectTime)
        {
            self _setAFK(true);
        }

        wait 1;
    }
}
