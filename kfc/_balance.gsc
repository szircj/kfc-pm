// Made by szir for KFC Mod
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

init()
{
    // Initialize balance monitoring
    [[level.on]]("spawned", ::BalanceTeams);
}

BalanceTeams()
{
    // End conditions for balance monitoring
    level endon("vote started");
    level endon("game_ended");

    // Variables to keep track of team balances
    int team1Count = 0;
    int team2Count = 0;

    while (true)
    {
        wait 10;  // Adjust the interval as needed

        // Count the number of players in each team
        team1Count = countPlayersInTeam("team1");
        team2Count = countPlayersInTeam("team2");

        // Balance teams if needed
        if (team1Count > team2Count + 1)
        {
            // Move a player from team1 to team2
            player = getPlayerFromTeam("team1");
            if (player)
            {
                movePlayerToTeam(player, "team2");
                iPrintln(player.name + " has been moved to team2 to balance teams.");
            }
        }
        else if (team2Count > team1Count + 1)
        {
            // Move a player from team2 to team1
            player = getPlayerFromTeam("team2");
            if (player)
            {
                movePlayerToTeam(player, "team1");
                iPrintln(player.name + " has been moved to team1 to balance teams.");
            }
        }
    }
}

// Helper functions
int countPlayersInTeam(string team)
{
    // Implement this function to count the number of players in the specified team
    return 0;  // Placeholder
}

player getPlayerFromTeam(string team)
{
    // Implement this function to get a player from the specified team
    return null;  // Placeholder
}

void movePlayerToTeam(player, string team)
{
    // Implement this function to move the specified player to the specified team
}
