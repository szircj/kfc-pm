// made by yowisf for KFC Promod (beta version)

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
    // Create a background for the table
    bg = newClientHudElem();
    bg.elemType = "bar";
    bg.x = 0.3; // Position on the screen (horizontal)
    bg.y = 0.3; // Position on the screen (vertical)
    bg.width = 400; // Width of the background
    bg.height = 300; // Height of the background
    bg.color = (0, 0, 0); // Black background
    bg.alpha = 0.7; // Slight transparency

    // Display player data on the HUD
    for (int i = 0; i < top10Players.size(); i++) {
        player = top10Players[i];
        text = newClientHudElem();
        text.elemType = "text";
        text.x = 0.31; // Position text slightly offset from background
        text.y = 0.31 + (i * 0.03); // Space out each entry
        text.font = "objective"; // Use a clear, readable font
        text.fontscale = 1.2; // Larger font size
        text.color = (1, 1, 1); // White text
        text setText("Position: " + (i + 1) + " Name: " + player.player_name + " [ID: " + player.player_id + "] Kills: " + player.kills + " Deaths: " + player.deaths + " Time: " + player.play_time);
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
