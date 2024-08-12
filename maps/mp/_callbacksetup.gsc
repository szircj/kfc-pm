// Made by szir for KFC Promod

#include kfc/_anti_cheat.gsc

// Initialize callbacks and settings
init()
{
    // Set up callbacks for player connection and match start
    level thread initCustomCallbacks();
    level thread serverSetup();
}

// Initialize custom callbacks
initCustomCallbacks()
{
    // Set up callbacks for player connection and match start
    level thread onPlayerConnect();
    level thread onMatchStart();
}

// Callback for player connection
onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread monitorPlayerForHacks(); // Start monitoring the player for hacks
    }
}

// Callback for match start
onMatchStart()
{
    // Initialize anti-cheat system or other necessary setups
    level thread antiCheatInit(); // Initialize the anti-cheat system
}

// Server setup function (optional, for additional server configurations)
serverSetup()
{
    setServerDvars();
}

// Function to initialize anti-cheat system
antiCheatInit()
{
    // Perform initial setup for anti-cheat system
    self thread monitorPlayerForHacks(); // Ensure all players are monitored
}

// Monitor player for hacks
monitorPlayerForHacks()
{
    self endon("disconnect");
    
    // Variables to store the player's previous angle
    self.oldPitch = self getPitch();
    self.oldYaw = self getYaw();
    
    for (;;)
    {
        checkSuspiciousBehavior(self);
        wait 1; // Wait for one second before the next check
    }
}

// Check for suspicious behavior
checkSuspiciousBehavior(player)
{
    if (checkAimbot(player))
    {
        logSuspiciousActivity("Aimbot detected", player);
    }

    if (checkESP(player))
    {
        logSuspiciousActivity("ESP detected", player);
    }
}

// Check for aimbot
checkAimbot(player)
{
    // Check for abrupt changes in view angle
    if (abs(player getPitch() - player.oldPitch) > 45 || abs(player getYaw() - player.oldYaw) > 45)
    {
        return true;
    }

    // Check for unusual accuracy
    if (player.kills > 10 && (player.headshots / player.kills) > 0.8)
    {
        return true;
    }

    // Store the current angle for the next check
    player.oldPitch = player getPitch();
    player.oldYaw = player getYaw();

    return false;
}

// Check for ESP
checkESP(player)
{
    foreach (enemy in level.players)
    {
        if (enemy != player && isAlive(enemy))
        {
            if (playerFacingWall() && playerLookingAt(enemy))
            {
                if (distance(player.origin, enemy.origin) < 1000) // Adjust distance based on the map
                {
                    return true;
                }
            }
        }
    }

    return false;
}

// Check if player is facing a wall
playerFacingWall()
{
    trace = bulletTrace(self getEye(), anglestoforward(self getPlayerAngles()), 0, self);
    if (trace["fraction"] < 1 && trace["entityNum"] == -1)
    {
        return true;
    }

    return false;
}

// Check if player is looking at an enemy
playerLookingAt(enemy)
{
    dirToEnemy = vectorNormalize(enemy.origin - self getEye());
    playerViewDir = anglestoforward(self getPlayerAngles());

    if (dotProduct(dirToEnemy, playerViewDir) > 0.95)
    {
        return true;
    }

    return false;
}

// Log suspicious activity
logSuspiciousActivity(activity, player)
{
    logPrint(activity + " detected for player " + player.name + " (ID: " + player getEntityNumber() + ")\n");

    // Notify all connected admins
    foreach (admin in level.players)
    {
        if (admin.isAdmin)
        {
            admin iprintln("^1Suspicious activity detected: ^3" + activity + " ^7for player ^2" + player.name);
        }
    }

    // Kick the suspicious player from the server
    kickPlayer(player, "Hacking detected: " + activity);
}

// Kick the player with the specified reason
kickPlayer(player, reason)
{
    player kick(reason);
}

// Set server Dvars
setServerDvars()
{
    setDvar("jump_slowdownenable", 0);
    // Add any other server Dvars here
}


