// Made by szir & yowisf for KFC Promod
#include maps\mp\_utility;

// Global variables to store player data
global playerRecords;

init()
{
    playerRecords = [];
}

storePlayerData(player)
{
    // Create a record for the player with their statistics
    record = {
        "player_id": player getClientDvar("clanName"),
        "player_name": player.name,
        "kills": player getClientDvar("kills"),
        "deaths": player getClientDvar("deaths"),
        "play_time": player getClientDvar("playTime")
    };
    
    // Add or update the player's record in the global playerRecords array
    playerRecords[player.getClientDvar("clanName")] = record;
}

getPlayerData(playerId)
{
    if (isDefined(playerRecords[playerId]))
    {
        return playerRecords[playerId];
    }
    else
    {
        return null;
    }
}

updatePlayerData(playerId, kills, deaths, playTime)
{
    if (isDefined(playerRecords[playerId]))
    {
        playerRecords[playerId].kills = kills;
        playerRecords[playerId].deaths = deaths;
        playerRecords[playerId].play_time = playTime;
    }
}

savePlayerDataToDatabase(playerId)
{
    playerData = getPlayerData(playerId);

    if (playerData != null)
    {
        url = "http://your-server-address/kfc_db.php";
        data = {
            "player_id": playerData.player_id,
            "player_name": playerData.player_name,
            "kills": playerData.kills,
            "deaths": playerData.deaths,
            "play_time": playerData.play_time
        };

        httpPost(url, data);
    }
}

// Call the initialization function
init();
