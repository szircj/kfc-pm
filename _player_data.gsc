// made by yowisf for KFC Promod (beta)

// Global variables to store player data table
global top10Players;

// Function to send player data to the database
sendPlayerData(player) {
    url = "http://your-server-address/kfc_db.php";
    data = {
        "player_id": player.getClientDvar("clanName"),
        "player_name": player.name,
        "kills": player.getClientDvar("kills"),
        "deaths": player.getClientDvar("deaths"),
        "play_time": player.getClientDvar("playTime")
    };

    httpPost(url, data);
}

// Function to get the top 10 players data
getTop10Players() {
    url = "http://your-server-address/kfc_db.php";
    response = httpGet(url);
    top10Players = parseJson(response);
}

// Function to display the top 10 players table in the HUD
showTop10HUD() {
    for (int i = 0; i < top10Players.size(); i++) {
        player = top10Players[i];
        // Display player data on the HUD (simplified)
        drawText("Position: " + (i + 1) + " Name: " + player.player_name + " [ID: " + player.player_id + "] Kills: " + player.kills + " Deaths: " + player.deaths + " Time: " + player.play_time, 0, 0 + (i * 20), 1);
    }
}

// Function to initialize player data
initPlayerData() {
    foreach (level.players as player) {
        sendPlayerData(player);
    }
}

// Function to handle key presses
onKeyPress() {
    while (true) {
        if (isKeyPressed("b")) {
            getTop10Players();
            showTop10HUD();
            wait(5000); // Wait 5 seconds before allowing another key press
        }
        wait(100); // Wait 100 ms between key checks
    }
}

// Call initialization function when the script loads
initPlayerData();

// Run the key press handling function
onKeyPress();
