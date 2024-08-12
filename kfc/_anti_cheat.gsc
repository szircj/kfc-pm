// made by szir for KFC Promod (beta version Cod4x)

main()
{
    // Initialize player monitoring and other functions
    level thread monitorPlayerForHacks();
}

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

checkESP(player)
{
    // Check if the player is looking at an enemy through a wall
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

playerFacingWall()
{
    // Check if the player is facing a wall
    trace = bulletTrace(self getEye(), anglestoforward(self getPlayerAngles()), 0, self);
    if (trace["fraction"] < 1 && trace["entityNum"] == -1)
    {
        return true;
    }

    return false;
}

playerLookingAt(enemy)
{
    // Check if the player is looking at the enemy
    dirToEnemy = vectorNormalize(enemy.origin - self getEye());
    playerViewDir = anglestoforward(self getPlayerAngles());

    // Check if the player's view direction and the direction to the enemy are nearly the same
    if (dotProduct(dirToEnemy, playerViewDir) > 0.95)
    {
        return true;
    }

    return false;
}

logSuspiciousActivity(activity, player)
{
    logPrint(activity + " detected for player " + player.name + " (ID: " + player getEntityNumber() + ")\n");

    // Store the log in the database
    storeLogInDatabase(player, activity);

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

storeLogInDatabase(player, activity)
{
    url = "http://your-server-address/kfc_db.php";
    data = {
        "player_id": player.getClientDvar("clanName"),
        "activity": activity
    };

    httpPost(url, data);
}

kickPlayer(player, reason)
{
    // Kick the player with the specified reason
    player kick(reason);
}
